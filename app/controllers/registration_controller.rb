class RegistrationController < Devise::RegistrationsController
  #Overridden devise methods
  # before_filter :require_no_authentication
  before_filter :require_admin?, :only => [:new, :create, :update]

  def new
    build_resource({})
    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)
    debugger
    resource.add_role("Poast Master")
    resource.company_attributes = {:name => params[:name].to_s.downcase.strip,:website => params[:website].to_s.downcase.strip}

    if resource.save
        expire_data_after_sign_in!
        flash[:notice] = "A user account has been created. A confirmation email has been sent to the user."
        redirect_to new_user_registration_url
        #respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def edit
    @resource = User.find(params[:id])
    render 'edit'
  end

  def update
    @resource = User.find(params[:id])
    @resource.update_role("Poast Master")
    
    if @resource.update_attributes(params[:user])
      flash[:notice] = "User updated successfully."
      redirect_to users_path
    else
      self.resource = @resource
      render 'edit'
    end
  end

  def after_sign_up_path_for
    new_user_registration_url
  end

  def after_inactive_sign_up_path_for(resource)
    admin_new_user_url
  end

  def new_super_admin
    build_resource({})
    respond_with self.resource
  end

  def create_super_admin
    build_resource(sign_up_params)
    resource.add_role("Super Admin")

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        redirect_to new_admin_url
      else
        expire_data_after_sign_in!
        flash[:notice] = "Admin account has been created. A confirmation email has been sent to the admin."
        redirect_to new_admin_url
      end
    else
      clean_up_passwords resource
      render 'new_super_admin'
    end
  end

  def edit_admin
    @resource = User.find(params[:id])
    self.resource = @resource
    render 'edit_admin'
  end

  def update_admin
    @resource = User.find(params[:id])
    @resource.update_role("Super Admin")

    if @resource.update_attributes(params[:user])
      flash[:notice] = "Admin updated successfully."
      redirect_to list_path
    else
      self.resource = @resource
      render 'edit_admin'
    end
  end

  private

  # This is an overridden method of the devise before filter.
  # This ensures that logged in users don't have access to the sign up page
  # It has been modified to allow admins and super admins to access the create user page.
  def require_no_authentication
    assert_is_devise_resource!
    return unless is_navigational_format?
    no_input = devise_mapping.no_input_strategies

    authenticated = if no_input.present?
                      args = no_input.dup.push :scope => resource_name
                      warden.authenticate?(*args)
                    else
                      warden.authenticated?(resource_name)
                    end

    if authenticated && resource = warden.user(resource_name)
      # do nothing and let the request progress else redirect
      if !resource.has_any_role?(:super_admin)
        flash[:alert] = I18n.t("devise.failure.already_authenticated")
        redirect_to after_sign_in_path_for(resource)
      end
    end
  end
end


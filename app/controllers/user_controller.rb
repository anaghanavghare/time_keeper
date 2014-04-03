class UserController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  layout 'application'
  def index
  	
  end

  def create
  	@user = params[:user]
    @user.add_role(params[:user][:role])
  	if @user.save
  		response_hash = {:users_count => users.count}
      render :json => response_hash, :status => :ok
    else
      response_hash = {:errors => @user.errors.full_messages}
      render :json => response_hash, :status => :error
  	end
  end

  def update
    @user = User.find(params[:id])
    @user.update_role(params[:user][:role])
    if @user.update_attributes
      response_hash = {:users_count => users.count}
      render :json => response_hash, :status => :ok
    else
      response_hash = {:errors => @user.errors.full_messages}
      render :json => response_hash, :status => :error
    end
  end
end

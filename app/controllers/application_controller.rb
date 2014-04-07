class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #helper_method :require_admin?
  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

    def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end

  def require_admin?
    if !(current_user && current_user.has_any_role?(:admin))
      sign_out(current_user)
      flash.clear
      flash[:alert] = "That page does not exist."
      redirect_to root_url
    end
  end
end

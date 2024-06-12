require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # include Pundit::Authorization
  # before_action :authenticate_user!
  # before_action :require_admin
  layout :layout_by_resource
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_if_unverified

  rescue_from CanCan::AccessDenied do |exception|
    redirect_back(fallback_location: root_path)
    flash[:alert] = "You are not authorized to perform this action."
    # respond_to do |format|
    #   format.json { head :forbidden, content_type: 'text/html' }
    #   format.html { redirect_to new_user_session_path, :alert => exception.message }
    #   format.js   { head :forbidden, content_type: 'text/html' }
    # end
  end

  # for pin verify function
  
  def redirect_if_unverified
    if current_user.nil?
    else
      return unless signed_in? && !current_user.verified?
      redirect_to verify_path, notice: "Please verify your email address"
    end
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  private

  def layout_by_resource
    if devise_controller? #Add later: skip landing if logged in. 
      "application_web"
    else
      "application"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :user_name, :phone_number, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])

    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :user_name, :phone_number, :address, :password, :password_confirmation, :verified)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit(:email, :password, :password_confirmation, :verified)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :verified)
    end
  end

end

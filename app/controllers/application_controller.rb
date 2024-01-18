class ApplicationController < ActionController::Base
  # include Pundit::Authorization
  # before_action :authenticate_user!
  # before_action :require_admin
  layout :layout_by_resource
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_if_unverified

  def redirect_if_unverified
    return unless signed_in? && !current_user.verified?

    redirect_to verify_path, notice: "Please verify your email address"
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
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:email])

    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :verified)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit(:email, :password, :password_confirmation, :verified)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :verified)
    end
  end

end

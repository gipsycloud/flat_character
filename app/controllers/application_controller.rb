class ApplicationController < ActionController::Base
  # include Pundit::Authorization
  # before_action :authenticate_user!
  # before_action :require_admin
  layout :layout_by_resource
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

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
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

end

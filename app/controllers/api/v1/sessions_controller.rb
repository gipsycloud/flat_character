# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def respond_with(resource, _opts = {})
    render json: { 
      message: 'Logged in successfully.', 
      user: resource,
      token: current_token
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise[:jwt_secret_key]).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: { message: 'Logged out successfully.' }, status: :ok
    else
      render json: { message: 'User not found.' }, status: :unauthorized
    end
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

end

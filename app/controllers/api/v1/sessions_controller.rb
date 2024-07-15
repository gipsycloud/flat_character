# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by_email(params[:email])
    
    if user && user.valid_password?(params[:password])
      # byebug
      payload = { user_id: user.id }
      secret = ENV["SECRET_KEY_BASE"] || Rails.application.secrets.secret_key_base
      @current_user = user
      render json: { 
        message: 'Logged in successfully.', 
        user: @current_user,
        # token: create_token(payload)
      }, status: :ok
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

end

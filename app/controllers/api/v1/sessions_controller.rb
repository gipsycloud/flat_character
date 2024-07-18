# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::BaseController
  respond_to :json

  skip_before_action :authenticate, only: [:create]

  # POST /resource/sign_in
  def create
    user = User.find_by_email(params[:email])
    
    if user
      if user.valid_password?(params[:password])
        token = JsonWebToken.encode(user_id: user.id)
        expires_at = JsonWebToken.decode(token)[:exp]
        render json: { 
          message: 'Logged in successfully.',
          token: token,
          exp: expires_at,
          user: user,
        }, status: :ok
      else
        render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
      end
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

end

# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::BaseController
  respond_to :json

  skip_before_action :authenticate_request, only: [:create]

  # POST /resource/sign_in
  def create
    user = User.find_by_email(params[:email])
    
    if user
      if user.valid_password?(params[:password])
        token = jwt_encode(user_id: user.id)
        expires_at = jwt_decode(token)[:exp]
        @current_user = user
        render json: { 
          message: 'Logged in successfully.',
          token: token,
          exp: expires_at,
          user: @current_user,
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

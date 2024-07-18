class Api::V1::BaseController < ApplicationController
  respond_to :json
  before_action :authenticate

  # rescue_from JWT::VerificationError, with: :invalid_token
  # rescue_from JWT::DecodeError, with: :decode_error

  # private

  def authenticate
    # authorization_header = request.headers['Authorization']
    # token = authorization_header.split(" ").last if authorization_header
    # decoded_token = JsonWebToken.decode(token)
 
    # User.find(decoded_token[:user_id])
    if request.headers["Authorization"]
      begin
        auth_header = request.headers["Authorization"]
        decoded_token = JsonWebToken.decode(token, secret)
        payload = decoded_token.first
        user_id = payload["user_id"]
      rescue => exception
        render json: { message: "Error: #{exception}"}, status: :forbidden
      end
    else
      render json: { message: "No Authorization header sent"}, status: :forbidden
    end
  end

  def token
    auth_header.split("")[1]
  end

  def secret
    secret = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  end

  def create_token(payload)
    JsonWebToken.encode(payload, secret)
  end
 
  # def invalid_token
  #   render json: { invalid_token: 'invalid token' }
  # end
 
  # def decode_error
  #   render json: { decode_error: 'decode error' }
  # end
end

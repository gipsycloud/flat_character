require 'jwt'
module JsonWebToken
  extend ActiveSupport::Concern
  
  JWT_SECRET = Rails.application.secrets.secret_key_base

  class DecodeError < StandardError; end
  class ExpiredSignature < StandardError; end
  
  def jwt_encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET)
  end
  
  def jwt_decode(token)
    decoded = JWT.decode(token, JWT_SECRET)[0]
    HashWithIndifferentAccess.new decoded
  end
  
  included do
    rescue_from JsonWebToken::DecodeError do |_error|
      render json: {
        message: "Access denied!. Invalid token supplied."
      }, status: :unauthorized
    end
    rescue_from JsonWebToken::ExpiredSignature do |_error|
      render json: {
        message: "Access denied!. Token has expired."
      }, status: :unauthorized
    end
  end
end
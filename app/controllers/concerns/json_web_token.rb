require 'jwt'
module JsonWebToken
  extend ActiveSupport::Concern
  
  # `Rails.application.secrets` was removed from newer Rails versions.
  # Use a dedicated JWT secret when configured, falling back to Rails' main
  # application secret for existing deployments.
  JWT_SECRET = ENV.fetch("JWT_SECRET_KEY") { Rails.application.secret_key_base }.freeze

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

class Api::V1::BaseController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split('').last if header
    @decoded = JsonWebToken.decode(header)
    begin
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end

# https://github.com/wardencommunity/warden/wiki/Strategies#authenticate

# https://stackoverflow.com/questions/34526544/undefined-method-authenticate-in-ruby-on-rails
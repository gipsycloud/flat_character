class Api::V1::BaseController < ApplicationController
  respond_to :json
  include JsonWebToken
  before_action :authenticate_request
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  private

  def authenticate_request
    if request.headers["Authorization"]
      begin
        auth_header = request.headers["Authorization"]
        token = auth_header.split(" ").last if auth_header
        decode = jwt_decode(token)
        @current_user = User.find(decode[:user_id])
      rescue => exception
        render json: { message: "Error: #{exception}"}, status: :forbidden
      end
    else
      render json: { message: "No Authorization header sent"}, status: :forbidden
    end
  end
end
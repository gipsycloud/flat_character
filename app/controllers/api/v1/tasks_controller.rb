class Api::V1::TasksController < Api::V1::BaseController
  skip_before_action :authenticate_request
  skip_before_action :redirect_if_unverified
  def trigger
    puts "Auto request from node js"

    render json: { status: 'success', message: "Auto request from node js"}
  end
end

class Api::V1::Rooms::RoomsController < Api::V1::BaseController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  # before_action :authenticate_request
  def index
    @api_v1_rooms = Room.where(:user_id => current_user.id)
    respond_with(@api_v1_rooms)
  end
end

class RoomImagesController < ApplicationController
  before_action :set_room_image

  def create
    @room_image = RoomImage.create(room_id: @image.id, room_image: params[:room][:room_image])
    @room_image.save
    redirect_to @image
    flash[:alert] = "Image has been deleted." unless @room_image.save
  end

  def destroy
    room = Room.find_by_id(params[:room_id])
    @image = RoomImage.find(params[:id])
    @image.destroy

    redirect_to room
    flash[:alert] = "Image has been deleted."
  end

  private

  def set_room_image
    @image = Room.find_by_slug(params[:room_id])
  end
end

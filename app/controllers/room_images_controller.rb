class RoomImagesController < ApplicationController
  before_action :set_room

  def create
    @room_image = @room.room_images.build(room_image: params.dig(:room, :room_image))

    if @room_image.save
      redirect_to @room, notice: "Image has been uploaded."
    else
      redirect_to @room, alert: @room_image.errors.full_messages.to_sentence
    end
  end

  def destroy
    @image = @room.room_images.find(params[:id])
    @image.destroy

    redirect_to @room, notice: "Image has been deleted."
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end
end

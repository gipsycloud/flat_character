class RoomImagesController < ApplicationController
  # def destroy
  #   remove_image_at_index(params[:room_id].to_i)
  #   flash[:error] = "Failed deleting image" unless @image.save
  #   redirect_to :back
  # end

  def destroy
    room = Room.find_by_id(params[:room_id])
    @image = RoomImage.find(params[:id])
    @image.destroy

    redirect_to room
    flash[:alert] = "Image has been deleted."

    # respond_to do |format|
    #   format.html { redirect_to room, notice: 'Image has been deleted' } 
    #   format.json { head :no_content }
    #   format.js   { render layout: false}
    # end
  end

  private

  def set_room_image
    @image = Room.find_by_slug(params[:room_id])
    @image_id = @image.id
  end

  def remove_image_at_index(index)
    @image = Room.find_by_id(params[:room_id])
    remain_image = @image.room_images
    deleted_image = remain_image.destroy
    deleted_image.try(:remove!)
    @image.room_images = remain_image
  end
end

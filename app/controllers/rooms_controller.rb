class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.where(:user_id => current_user.id)
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    # authorize! :read, @room 
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @room_image = @room.room_images.build
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id

    respond_to do |format|
      if @room.save
        store_image
        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        store_image
         # if @post_attachment.update(post_attachment_params)
        #   format.html { redirect_to @post_attachment.post, notice: 'Post attachment was successfully updated.' }
        # end
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:roomType, :maxPersons, :roomPrice, :gender, :roomNumber, :details, :startDate, :endDate, 
        :floor, :address, :room_status, :feedback, :image, room_images_attributes: [:room_image, :room_id])
    end

    def store_image
      if params[:room_images]
        params[:room_images].each do |image|
          @room.room_images.create!(room_image: image)
        end
      end
    end
end

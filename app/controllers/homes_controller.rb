class HomesController < ApplicationController
  before_action :set_home, only: %i[ show edit update destroy ]
  layout 'layouts/application_web'

  # GET /homes or /homes.json
  def index
    @rooms = Room.order(updated_at: :desc).limit(4)
    @plans = Plan.first
    @q = User.ransack(params[:q])
    @members = @q.result(distinct: true)
    if params[:q]
      render 'search'
    end
    
  end

  def search
    # @q = User.ransack(params[:q])
    # @members = @q.result(distinct: true)
    # if params[:q].present?
    #   redirect_to( search_homes_path(@q), format: :html)
    # end
  end

  # GET /homes/1 or /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes or /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to home_url(@home), notice: "Home was successfully created." }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1 or /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to home_url(@home), notice: "Home was successfully updated." }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1 or /homes/1.json
  def destroy
    @home.destroy

    respond_to do |format|
      format.html { redirect_to homes_url, notice: "Home was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def room_detail
    @room = Room.find_by_slug(params[:slug])
  end

  def list_a_room
    @rooms = Room.all
  end

  def find_a_home
  end

  def find_a_flatmate
  end

  def aboutus
  end

  def services
  end
  
  def contact
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def home_params
      params.fetch(:home, {})
    end
end

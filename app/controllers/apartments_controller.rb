class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[show edit update destroy]

  def index
    @apartments = Apartment.available_now.order(created_at: :desc)
    @apartments = @apartments.where(lifestyle_mode: params[:lifestyle_mode]) if params[:lifestyle_mode].present?
    # @apartments.where(lifestyle_mode: params[:lifestyle]) if params[:lifestyle].in?(Apartment.lifestyle_modes.keys)
  end

  def show
    @nearby_jobs = if @apartment.latitude && @apartment.longitude
                     JobListing.active.near([@apartment.latitude, @apartment.longitude], 10)
                   else
                     []
                   end
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = current_user.apartments.build(apartment_params)
    if @apartment.save
      redirect_to @apartment, notice: 'Apartment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @apartment.update(apartment_params)
      redirect_to @apartment, notice: 'Apartment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @apartment.destroy
    redirect_to apartments_url, notice: 'Apartment was successfully destroyed.'
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(:title, :description, :address, :city,
                                      :monthly_rent, :currency, :bedrooms, :bathrooms,
                                      :size_m2, :lifestyle_mode, :status, :available_from)
  end
end
class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[show edit update destroy]

  PER_PAGE = 10
  
  def index
    scope = Apartment.where.not(status: :hidden)

    scope = scope.where(lifestyle_mode: params[:lifestyle_mode])     if params[:lifestyle_mode].present?
    scope = scope.where(city: params[:city])                         if params[:city].present?
    scope = scope.where("monthly_rent <= ?", params[:max_rent])      if params[:max_rent].present?
    scope = scope.where("bedrooms >= ?",  params[:bedrooms])         if params[:bedrooms].present?

    case params[:sort]
    when "price_asc"  then scope = scope.order(monthly_rent: :asc)
    when "price_desc" then scope = scope.order(monthly_rent: :desc)
    else                   scope = scope.order(created_at: :desc)
    end

    @total = scope.count
    @pages = (@total / PER_PAGE.to_f).ceil
    @page  = [params.fetch(:page, 1).to_i, 1].max
    @page  = [@page, @pages].min if @pages.positive?

    @apartments = scope.offset((@page - 1) * PER_PAGE).limit(PER_PAGE)
    @cities = Apartment.where.not(city: [nil, ""]).distinct.order(:city).pluck(:city)
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
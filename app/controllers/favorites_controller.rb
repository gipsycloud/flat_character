class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorite_apartments = current_user.favorite_apartments
  end

  def create
    apartment = Apartment.find(params[:apartment_id])
    current_user.favorites.find_or_create_by(apartment: apartment)
    redirect_to fallback_location: root_path, notice: "Apartment added to favorites." 
  end

  def destroy
    current_user.favorites.find(params[:id]).destroy
    redirect_to fallback_location: root_path, notice: "Removed from favorites."
  end
end

class Web::PropertiesController < ApplicationController
  def room_checkout
    @checkout = Property.new
    @checkout.room_id = params[:room][:room_id]
    @checkout.user_id = current_user.id
    @checkout.phone_number = params[:room][:phone_number]
    @checkout.room_price = params[:room][:room_price]
    @checkout.start_date = params[:room][:start_date]
    @checkout.end_date = params[:room][:end_date]
    @checkout.save
  end
end

class Web::PropertiesController < ApplicationController
  # before_action :require_login
   layout 'layouts/application_web'

  def room_checkout
    # @checkout = Property.new
    # @checkout.room_id = params[:room][:room_id]
    # # @checkout.user_id = current_user.id
    # @checkout.phone_number = params[:room][:phone_number]
    # @checkout.room_price = params[:room][:room_price]
    # @checkout.total_amount = params[:room][:total_checkout]
    # @checkout.start_date = params[:room][:start_date]
    # @checkout.end_date = params[:room][:end_date]
    # # @checkout.address
    # # @checkout.save
    # if @checkout.save
    #   respond_to do |format|
    #     # format.turbo_stream
    #     format.html { redirect_to root_url, notice: "Room Booking was successfully created." }
    #   end
    # else
    #   respond_to do |format|
    #     # format.turbo_stream
    #     format.html
    #   end
    # end
  end

  def reserve
    
  end

  def confirm_reserve
    @checkout = Property.new
    @checkout.room_id = params[:room_id]
    @checkout.user_id = current_user.id if current_user
    @checkout.guest_count = params[:guest_count]
    @checkout.phone_number = params[:customer_phone]
    @checkout.room_price = params[:price]
    @checkout.service_fee = params[:service_fee]
    @checkout.cleaning_fee = params[:cleaning_fee] || '0'
    @checkout.total_amount = params[:total]
    @checkout.start_date = params[:start_date]
    @checkout.end_date = params[:end_date]
    @checkout.save
  end

  private

    # def checkout_params
    #   params.require(:property).permit(:room_id, :user_id, :phone_number, :room_price, :total_amount, :customer_phone, :start_date, :end_date)
    # end

    def require_login
      unless current_user
        redirect_to new_user_session_url
        flash[:alert] = "Please, login if you are not login !!"
      end
    end
end

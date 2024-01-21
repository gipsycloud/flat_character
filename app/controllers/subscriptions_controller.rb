class SubscriptionsController < ApplicationController
  # skip_before_action :authenticate_user
  layout 'layouts/application_web'
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      flash[:success] = "Subscription successful! You will receive new articles via email"
    else
      flash[:error] = "Subcription failed. Please try again"
    end
    redirect_to root_path
  end

  private

  def subscription_params
    params.require(:subscription).permit(:email)
  end
end

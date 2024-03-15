class Admins::DashboardController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :redirect_if_unverified
  def index
    @subscribe = Subscription.all
    @members = Member.all
  end

  def homelist
  end
end

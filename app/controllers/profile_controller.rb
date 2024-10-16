class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ profile update_member ]
  layout 'layouts/application'

  def profile
    # @user = current_user
    @subscription = Subscription.where(email: current_user.email).first
  end

  def update_member
    @user.update(user_params)
    redirect_to detail_profile_index_url
    flash[:alert] = "Member was successfully updated."
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:user_name, :phone_number, :address, :role, :verified, :avatar, :notify_when_added_to_room, user_info_attributes: [:id, :job_type, :details, :plan, :hobby, :favourite, :facebook_link, :instagram, :twitter, :linkedin, manner_categories: [] ])
  end

  def update_user_params
    params.require(:user).permit(:user_name, :phone_number, :address, :role, :verified, :avatar)
  end
end

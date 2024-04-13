class UpgradeController < ApplicationController
  before_action :set_upgrade, only: %i[ show edit update ]
  before_action :authenticate_user!
  before_action :set_user, only: %i[ plan_upgrade ]
  
  # load_and_authorize_resource

  def index
    @upgrades = Upgrade.where(user_id: current_user.id)
    @plan = Upgrade.find_by(user_id: current_user.id, status: "active")
    @transaction_records = Payment.where(user_id: current_user.id)
  end

  def show
  end

  def edit
  end

  private

  def set_upgrade
    @upgrade = Upgrade.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def transaction_params
    params.require(:upgrade).permit(:plan_id)
  end
end

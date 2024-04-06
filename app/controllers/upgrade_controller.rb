class UpgradeController < ApplicationController
  before_action :set_upgrade, only: %i[ show edit update ]
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @upgrades = Upgrade.where(user_id: current_user.id)
    @plan = Upgrade.find_by(user_id: current_user.id, status: "active")
  end

  def show
  end

  def edit
  end

  def plan_upgrade
    # @transaction.update
  end

  private

  def set_upgrade
    @upgrade = Upgrade.find(params[:id])
  end
end

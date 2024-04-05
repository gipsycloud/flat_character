class UpgradeController < ApplicationController
  before_action :set_upgrade, only: %i[ show edit update ]
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @upgrades = Upgrade.where(user_id: current_user.id)
  end

  def show
  end

  def edit
  end

  private

  def set_upgrade
    @upgrae = Upgrade.find(params[:id])
  end
end

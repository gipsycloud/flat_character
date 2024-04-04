class UpgradeController < ApplicationController
  def index
    @upgrades = Upgrade.all
  end
end

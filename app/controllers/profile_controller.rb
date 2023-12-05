class ProfileController < ApplicationController
  before_action :authenticate_user!
  layout 'layouts/application'

  def profile
  end
end

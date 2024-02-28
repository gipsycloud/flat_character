class MakesController < ApplicationController
  layout 'layouts/application_web'
  def index
    @user = User.all
  end
end

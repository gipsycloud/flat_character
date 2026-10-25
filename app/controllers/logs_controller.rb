class LogsController < ApplicationController
  def index
    @logs = File.read(Rails.root.join('log', "#{Rails.env}.log"))
    render plain: @logs
  end
end

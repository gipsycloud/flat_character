class Users::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @job_matcher = JobMatcher.new(@user)
    @matched_jobs = @job_matcher.matched_jobs(10)
  end

  def show

  end
end

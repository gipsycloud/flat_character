class CrawlSessionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @crawl_sessions = CrawlSession.includes(:job_source).order(started_at: :desc).limit(50)
  end

  def show
    @crawl_session = CrawlSession.includes(:job_source).find(params[:id])
  end 
end

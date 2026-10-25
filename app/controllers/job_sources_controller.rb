class JobSourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @job_sources    = JobSource.order(:name)
    @crawl_sessions = CrawlSession.includes(:job_source).order(started_at: :desc).limit(10)
    @stats = {
      listings: JobListing.count,
      active:   JobListing.active.count,
      saved:    SavedJob.count
    }
  end

  def show
    @crawl_session = CrawlSession.includes(:job_source).find(params[:id])
  end

  def crawl_now
    source = JobSource.find(params[:id])
    crawler = "Crawler::#{source.crawler_class_name}".constantize.new(source)
    crawler.crawl!              # runs synchronously — no queue

    session = source.crawl_sessions.order(:created_at).last
    if session&.completed?
      redirect_to admin_job_sources_path,
        notice: "Crawl done: #{session.listings_created} new, #{session.listings_updated} updated."
    else
      redirect_to admin_job_sources_path, alert: "Crawl failed: #{session&.error_message}"
    end
  rescue StandardError => e
    redirect_to admin_job_sources_path, alert: "Crawl failed: #{e.message}"
  end
end

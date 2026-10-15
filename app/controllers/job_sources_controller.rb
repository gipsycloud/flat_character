class JobSourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @job_sources = JobSource.all
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

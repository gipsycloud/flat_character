class JobListingsController < ApplicationController
  def index
    scope = JobListing.active.includes(:job_source, :job_category)
    scope = scope.where(job_source_id: params[:job_source_id]) if params[:job_source_id].present?
    scope = scope.where("title ILIKE :q OR company_name ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?

    if params[:near].present?
      lat, lng = params[:near].split(",").map(&:to_f)
      scope = scope.near([lat, lng], params.fetch(:radius, 10).to_f, units: :km)

      @job_listings = scope.order(posted_at: :desc).page(params[:page]).per(params.fetch(:per_page, 20))
    end

    def show
      @job_listing = JobListing.active.find(params[:id])
    end


  end
end

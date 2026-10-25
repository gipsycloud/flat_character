class JobListingsController < ApplicationController
  PER_PAGE = 20

  def index
    scope = JobListing.active.includes(:job_source)
    if params[:q].present?
      q = "%#{params[:q]}%"
      scope = scope.where("title ILIKE :q OR company_name ILIKE :q", q: q)
    end

    scope = scope.where(remote_status: params[:remote]) if params[:remote].present?
    scope = scope.where(job_category_id: params[:category]) if params[:category].present?
    # scope = scope.where(job_source_id: params[:job_source_id]) if params[:job_source_id].present?
    @pages = (scope.count / PER_PAGE.to_f).ceil
    @page  = [params.fetch(:page, 1).to_i, 1].max
    @page  = [@page, @pages].min if @pages.positive?

    @job_listings = scope.order(posted_at: :desc)
                         .offset((@page - 1) * PER_PAGE).limit(PER_PAGE)
    @categories = JobCategory.order(:name)

    # if params[:near].present?
    #   lat, lng = params[:near].split(",").map(&:to_f)
    #   scope = scope.near([lat, lng], params.fetch(:radius, 10).to_f, units: :km)

    #   @job_listings = scope.order(posted_at: :desc).page(params[:page]).per(params.fetch(:per_page, 20))
    #   @categories = JobCategory.order(:name)
    # end
  end

  def show
    @job_listing = JobListing.active.includes(:job_source).find(params[:id])
  end
end

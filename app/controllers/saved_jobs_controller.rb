class SavedJobsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @saved_jobs = current_user.saved_jobs.includes(job_listing: [:job_source, :job_category]).order(created_at: :desc).page(params[:page]).per(params.fetch(:per_page, 20))
  end

  def create
    job_listing = JobListing.active.find(params[:job_listing_id])
    if current_user.saved_jobs.exists?(job_listing_id: job_listing.id)
      render json: { error: "Job listing already saved." }, status: :unprocessable_entity
    else
      saved_job = current_user.saved_jobs.build(job_listing: job_listing)
      if saved_job.save
        redirect_back_or_to admin_job_listing_path(job_listing)
      else
        render json: { error: "Failed to save job listing." }, status: :unprocessable_entity
      end
    end

    
  end

  def destroy
    saved_job = current_user.saved_jobs.find_by(id: params[:id])

    if saved_job&.destroy
      redirect_back_or_to admin_job_listing_path(saved_job)
      # render json: { message: "Saved job removed successfully." }, status: :ok
    else
      redirect_back_or_to admin_job_listing_path(saved_job)
      # render json: { error: "Saved job not found or could not be removed." }, status: :not_found
    end
  end
end

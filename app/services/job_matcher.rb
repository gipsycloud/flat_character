class JobMatcher
  def initialize(user)
    @user = user
  end

  def jobs_near_apartment(apartment, radius = 10, limit = 10)
    JobListing.active.near([apartment.latitude, apartment.longitude], radius, units: :km).limit(limit)
  end

  def matched_jobs(limit =10)
    if preferred_apartment
      JobListing.active
                .where(job_category_id: @user.job_category_ids)
                .near([@user.latitude, @user.longitude], 10, units: :km)
                .limit(limit)
    else
      JobListing.active.order(posted_at: :desc).limit(limit)
    end
  end

  private

  def preferred_apartment
    @user.favorite_apartments.order(created_at: :desc).first
  end
end
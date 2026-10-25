class JobMatcher
  RADIUS_KM = 15

  def initialize(user)
    @user = user
  end

  def jobs_near_apartment(apartment, radius = 10, limit = 10)
    JobListing.active.near([apartment.latitude, apartment.longitude], radius, units: :km).limit(limit)
  end

  def matched_jobs(limit =10)
    nearby_jobs(limit: limit).presence || fallback_jobs(limit: limit)
    # apartment = preferred_apartment
    # if apartment&.latitude.present?
    #   JobListing.active
    #             .includes(:job_source)
    #             .near([apartment.latitude, apartment.longitude], RADIUS_KM, units: :km)
    #             .order(posted_at: :desc)
    #             .limit(limit)
    # else
    #   JobListing.active     # fallback: no favorites yet → remote-first, newest
    #             .includes(:job_source)
    #             .order(remote_status: :desc, posted_at: :desc)
    #             .limit(limit)
    # end
  end

  def self.jobs_near(apartment, limit: 5)
    return JobListing.none unless apartment&.latitude.present? && apartment.longitude.present?

    JobListing.active
      .where.not(latitude: nil)
      .near([apartment.latitude, apartment.longitude], RADIUS_KM, units: :km)
      .order(posted_at: :desc)
      .limit(limit)
  end

  private

  def nearby_jobs(limit:)
    apartment = preferred_apartment
    return JobListing.none unless apartment&.latitude.present? && apartment.longitude.present?

    JobListing.active
      .where.not(latitude: nil)
      .near([apartment.latitude, apartment.longitude], RADIUS_KM, units: :km)
      .order(posted_at: :desc)
      .limit(limit)
  end

  def fallback_jobs(limit:)
    JobListing.active
      .includes(:job_source)
      .order(remote_status: :desc, posted_at: :desc)
      .limit(limit)
  end

  def preferred_apartment
    @user.favorite_apartments.order(created_at: :desc).first
  end
end
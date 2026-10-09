class JobListing < ApplicationRecord
	enum :statue, { active: 0, inactive: 1, removed: 2 }
	enum :employment_type, { full_time: 0, part_time: 1, contract: 2, internship: 3, temporary: 4 }
	enum :remote_status, { remote: 0, hybrid: 1, on_site: 2 }

	belongs_to :job_source
	belongs_to :crawl_session, optional: true
	has_many :saved_jobs, dependent: :destroy

	geocoded_by :location
	after_validation :geocode, if: :will_save_change_to_location?

	scope :recent, -> { where(status: :active).order(created_at: :desc) }
end

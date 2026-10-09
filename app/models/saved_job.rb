class SavedJob < ApplicationRecord
	enum :status, { saved: 0, unsaved: 1 }
	belongs_to :user
	belongs_to :job_listing
	validates :job_listing_id, uniqueness: { scope: :user_id, message: "You have already saved this job." }
end

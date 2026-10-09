class JobCategory < ApplicationRecord
	has_many :job_listings, dependent: :destroy
	validates :name, presence: true, uniqueness: true
end

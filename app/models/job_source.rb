class JobSource < ApplicationRecord
  has_many :job_listings, dependent: :destroy
	has_many :crawl_sessions, dependent: :destroy

	validates :name, presence: true
	validates :base_url, presence: true
	validates :crawler_class, presence: true

	def due_for_crawl?
		active? && (last_crawled_at.nil? || last_crawled_at < crawl_interval_hours.hours.ago)
		# return true if last_crawled_at.nil?
		# Time.current - last_crawled_at >= crawl_interval.minutes
	end

end

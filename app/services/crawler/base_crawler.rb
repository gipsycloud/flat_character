module Crawler
  class BaseCrawler
    USER_AGENT = "RoommateAppJobBot/1.0 (+https://hostelmate.asia)"
    def initialize(job_source)
      @job_source = job_source
      @http = Faraday.new(headers: { 'User-Agent' => USER_AGENT }) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.options.timeout = 10
        faraday.options.open_timeout = 5
      end
    end

    def fetch_listings
			raise NotImplementedError, "Subclasses must implement the fetch_listings method"
		end

    def crawl!
			session = @job_source.crawl_sessions.create!(status: :in_progress, started_at: Time.current)
			created = updated = 0
			begin
				listings = fetch_listings
				listings.each do |listing_data|
					# @job_source.job_listings.create!(listing_data.merge(crawl_session: session))
					result = JobImporter.import(listing_data.merge(job_source: @job_source, crawl_session: session))
					result[:created] ? created += 1 : updated += 1
					sleep @job_source.config.fetch("crawl_delay_seconds", 2)
				end
				session.update!(status: :completed, listings_found: created + updated,
                      listings_created: created, listings_updated: updated, finished_at: Time.current)
				@job_source.update!(last_crawled_at: Time.current)
			rescue StandardError => e
				session.update!(status: :failed, error_message: e.message, finished_at: Time.current)
      	Rails.logger.error("[Crawler] #{@job_source.name} failed: #{e.message}")
			end
		end
	end
end
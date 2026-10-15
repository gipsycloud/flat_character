module Crawler
	class RemotiveCrawler < BaseCrawler
		def fetch_listings
			response = @http.get(@job_source.config["url"])
			if response.status == 200
				data = JSON.parse(response.body)
				data["jobs"].map do |job|
					{
						title: job["title"],
						company: job["company_name"],
						description: job["description"]&.gsub(/<[^>]+>/, ""), # strip HTML
						source_url: job["url"],
						location: job["candidate_required_location"],
						posted_at: Time.parse(job["publication_date"])
					}
				end
			else
				raise "Failed to fetch listings from Remotive. Status code: #{response.status}"
			end
		end
	end
end
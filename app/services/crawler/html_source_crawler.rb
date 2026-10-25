module Crawler
  class HtmlSourceCrawler < BaseCrawler
    def fetch_listings
      response = @http.get(source_url)
      if response.status == 200
        html = Nokogiri::HTML(response.body)
        listings = []
        html.css(@job_source.config["listing_selector"]).each do |listing_element|
          title_element = listing_element.at_css(@job_source.config["title_selector"])
          company_element = listing_element.at_css(@job_source.config["company_selector"])
          description_element = listing_element.at_css(@job_source.config["description_selector"])
          url_element = listing_element.at_css(@job_source.config["url_selector"])
          location_element = listing_element.at_css(@job_source.config["location_selector"])
          published_at_element = listing_element.at_css(@job_source.config["published_at_selector"])

          listings << {
            title: title_element&.text&.strip,
            company_name: company_element&.text&.strip,
            description: description_element&.text&.strip,
            source_url: url_element&.[]('href')&.strip,
            location: location_element&.text&.strip,
            posted_at: published_at_element ? Time.parse(published_at_element.text.strip) : nil
          }
        end
        listings
      else
        raise "Failed to fetch listings from HTML source. Status code: #{response.status}"
      end
    end
  end
end
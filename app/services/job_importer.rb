# app/services/job_importer.rb
class JobImporter
  def self.import(attrs)
    source = attrs.fetch(:job_source)
    source_url = attrs.fetch(:source_url)
    digest = Digest::SHA256.hexdigest(source_url)

    listing = JobListing.find_or_initialize_by(url_digest: digest) # unique index prevents dupes
    was_new = listing.new_record?
    listing.assign_attributes(attrs.except(:job_source, :crawl_session))
    listing.source_url = source_url
    listing.job_source_id = source.id
    listing.save!
    { listing: listing, created: was_new }
  rescue ActiveRecord::RecordNotUnique
    retry
  end
end
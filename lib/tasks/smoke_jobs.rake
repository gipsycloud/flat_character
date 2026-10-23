# lib/tasks/smoke_jobs.rake
namespace :smoke do
  desc "End-to-end check: crawl -> import -> dedup -> match -> save"
  task jobs: :environment do
    @failures = 0

    def check(label, condition, detail = "")
      @failures += 1 unless condition
      puts "#{condition ? "✅" : "❌"} #{label}#{detail.present? ? " (#{detail})" : ""}"
    end

    puts "── 1. Schema ──"
    check "job_listings table",      ActiveRecord::Base.connection.table_exists?(:job_listings)
    check "url_digest unique index", ActiveRecord::Base.connection.index_exists?(:job_listings, :url_digest, unique: true)
    check "apartments table",        ActiveRecord::Base.connection.table_exists?(:apartments)
    check "favorites table",         ActiveRecord::Base.connection.table_exists?(:favorites)

    puts "── 2. Crawl (real API call) ──"
    source = JobSource.find_or_initialize_by(name: "Remotive")
    source.assign_attributes(
      base_url: "https://remotive.com",
      crawler_class: "RemotiveCrawler",
      config: {
        "url" => "https://remotive.com/api/remote-jobs",
        "crawl_delay_seconds" => 0
      }
    )
    source.save!

    Crawler::RemotiveCrawler.new(source).crawl!
    session = source.crawl_sessions.order(:created_at).last
    check "crawl session completed", session&.completed?, session&.error_message.to_s
    check "listings in DB",          JobListing.count.positive?, "#{JobListing.count} listings"

    puts "── 3. Dedup ──"
    sample = JobListing.order(:id).first
    before = JobListing.count
    result = JobImporter.import(job_source: source, title: sample.title, source_url: sample.source_url)
    check "re-import does not duplicate", !result[:created] && JobListing.count == before

    puts "── 4. Match ──"
    user = User.first
    check "user exists", user.present?
    if user
      apt = Apartment.first ||
            Apartment.create!(title: "Smoke test apartment", address: "1 Market St, San Francisco",
                              lifestyle_mode: :calm, monthly_rent: 2000)
      check "apartment geocoded", apt.latitude.present?
      user.favorites.find_or_create_by!(apartment: apt)
      jobs = JobMatcher.new(user).matched_jobs(5)
      check "matcher returns jobs", jobs.any?, "#{jobs.size} jobs"
    end

    puts "── 5. Save ──"
    if user && (job = JobListing.active.first)
      saved = user.saved_jobs.find_or_create_by!(job_listing: job)
      check "job saved", saved.persisted?
    end

    puts ""
    if @failures.zero?
      puts "🎉 ALL CHECKS PASSED (#{JobListing.count} listings, #{SavedJob.count} saved)"
    else
      puts "💥 #{@failures} check(s) failed — see ❌ above"
    end
  end
end

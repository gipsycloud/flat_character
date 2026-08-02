module SidekiqScheduler
  module_function

  def load_schedule!
    return unless defined?(Rails) && Rails.respond_to?(:root)

    schedule_file = Rails.root.join("config", "schedule.yml")
    return unless File.exist?(schedule_file)

    schedule_data = YAML.safe_load(File.read(schedule_file), aliases: true) || {}
    Sidekiq::Cron::Job.load_from_hash(schedule_data)
  rescue Psych::Exception => e
    Rails.logger&.error("Unable to load Sidekiq cron schedule: #{e.message}")
  rescue StandardError => e
    Rails.logger&.error("Unable to load Sidekiq cron schedule: #{e.message}")
  end
end

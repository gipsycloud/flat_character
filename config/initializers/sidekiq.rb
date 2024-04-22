require 'sidekiq'
require 'sidekiq/web'
# require 'sidekiq-scheduler'
# require 'sidekiq-scheduler/web'
require 'sidekiq-status'

redis_url = ENV.fetch("REDIS_URL")

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    # accepts :expiration (optional)
    config.redis = { url: redis_url }
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes # default
  end
end

Sidekiq.configure_server do |config|
  # config.on(:startup) do
  #   Sidekiq.schedule = YAML.load_file(File.expand_path('../../schedule.yml', __FILE__))
  #   Sidekiq::Scheduler.reload_schedule!
  # end
  # schedule_file = "config/schedule.yml"
  # if File.exist?(schedule_file) && Sidekiq.server?
  #   Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  # end
  config.server_middleware do |chain|
    # accepts :expiration (optional)
    config.redis = { url: redis_url }
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  config.client_middleware do |chain|
    # accepts :expiration (optional)
    config.redis = { url: redis_url }
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes # default
  end
end

# sidekiq_cronの設定
schedule_file = 'config/schedule.yml'
Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
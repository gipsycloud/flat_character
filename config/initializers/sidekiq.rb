require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq-status'
require 'sidekiq/cron/web'

redis_url = ENV["REDIS_URL"]

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url } if redis_url.present?

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url } if redis_url.present?

  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes
  end

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 30.minutes
  end

  config.on(:startup) do
    if defined?(SidekiqScheduler)
      SidekiqScheduler.load_schedule!
    end
  end
end

if defined?(Rails) && Rails.application && Sidekiq.server?
  SidekiqScheduler.load_schedule! if defined?(SidekiqScheduler)
end
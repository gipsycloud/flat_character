require 'sidekiq'
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
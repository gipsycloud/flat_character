# config/initializers/redis.rb
REDIS_URL = ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" }
$redis = Redis.new(url: REDIS_URL)

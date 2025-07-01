web: env RUBY_DEBUG_OPEN=true bin/rails server -p 3000
redis: redis-server
css: bin/rails tailwindcss:watch
mail:       mailcatcher --smtp-ip 0.0.0.0 --http-ip 0.0.0.0 --foreground
worker:     bundle exec sidekiq -C config/sidekiq.yml

# job:     bundle exec sidekiq -C config/sidekiq_scheduler.yml


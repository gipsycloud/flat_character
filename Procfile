web: env RUBY_DEBUG_OPEN=true bin/rails server -p 3000
redis: redis-server
css: bin/rails tailwindcss:watch
worker: bundle exec sidekiq -C config/sidekiq.yml
# mail:       mailcatcher --smtp-ip 0.0.0.0 --http-ip 0.0.0.0 --foreground
# job:     bundle exec sidekiq -C config/sidekiq_scheduler.yml

# web: cd backend && bundle exec puma -C config/puma.rb
# node: cd frontend && npm install && npm start

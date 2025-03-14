source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"
gem 'pg', '~> 1.5', '>= 1.5.4'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

gem 'jquery-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
gem "redis-actionpack"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
gem 'sassc-rails'
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "hotwire-livereload"
  gem 'better_errors', '~> 2.9', '>= 2.9.1'
  gem "binding_of_caller"
  gem "meta_request"
  gem 'letter_opener'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'foreman', '~> 0.87.2'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :assets do
  gem 'coffee-rails'
end

gem "tailwindcss-rails", "~> 2.0"
gem 'jquery-rails'
# gem 'coffee-script', '~> 2.4', '>= 2.4.1'

gem 'devise'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'cancancan', '~> 3.5'
gem 'pundit', '~> 1.1'
# gem 'attachinary'
gem 'carrierwave', '~> 3.0'
gem 'cloudinary'
gem 'aws-sdk-s3'
gem 's3_direct_upload'
gem "responders"
gem 'simple_form'
gem 'simple_form-tailwind', '~> 0.1.1'

gem 'uri'

# gem 'sidekiq', '~> 7.1', '>= 7.1.2'
gem 'sidekiq', '~> 5.2.8'
gem 'sidekiq-status'
gem 'sidekiq-cron'

gem 'friendly_id', '~> 5.1'

gem 'ransack'

# api
gem 'jwt', '~> 1.5', '>= 1.5.4'
gem 'bcrypt', '~> 3.1', '>= 3.1.20'
gem 'jsonapi-serializer'

gem 'social-share-button'
# gem 'open_street_map'
gem 'mapkick-rb', '~> 0.1.5'
gem "geocoder", "~> 1.8"

gem 'syslogger', '~> 1.6.0'
gem 'lograge', '~> 0.3.1'
gem 'image_size', '~> 3.0'
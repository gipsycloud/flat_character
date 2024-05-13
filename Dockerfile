FROM ruby:3.2.1

# Set environment variables
ENV LANG C.UTF-8
ENV RAILS_ENV production

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Create a directory for the application
RUN mkdir /myapp
WORKDIR /myapp

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the application code into the container
COPY . .

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port 3000 to the Docker host, so it can be accessed from outside the container
EXPOSE 3000

# ENV RAILS_LOG_TO_STDOUT=true
# ENV RAILS_SERVE_STATIC_FILES=true

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

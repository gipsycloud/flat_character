# Use the official Ruby image
FROM ruby:3.2.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /myapp

# Cache and install gems
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Copy the rest of the application code
COPY . /myapp

# Precompile assets and other necessary tasks
RUN bundle exec rake assets:precompile
RUN bundle exec rake assets:clean

# Expose port 3000 to the Docker host
EXPOSE 3000

# Specify the command to run on container start
CMD ["rails", "server", "-b", "0.0.0.0"]

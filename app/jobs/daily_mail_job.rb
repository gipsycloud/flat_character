# require 'sidekiq-scheduler'

class DailyMailJob
  include Sidekiq::Worker

  sidekiq_options queue: :worker


  def perform(*args)
    puts "TaskLoggerJob is performed"
  end
end

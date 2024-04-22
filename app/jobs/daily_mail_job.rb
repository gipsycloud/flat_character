# require 'sidekiq-scheduler'

class DailyMailJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # enables job status tracking

  sidekiq_options queue: :mailer

  def expiration
    @expiration ||= 60*60*24*30 # 30 days
  end

  def perform
    puts "TaskLoggerJob is performed"
    AutoMailer.send_daily_posts_email.deliver_later
  end
end
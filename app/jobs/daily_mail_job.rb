class DailyMailJob < ApplicationJob
  queue_as :mailer

  def perform
    AutoMailer.send_daily_posts_email.deliver_later
  end
end

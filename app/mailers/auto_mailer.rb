class AutoMailer < ApplicationMailer
  def send_daily_posts_email(email)
    @today_posts = Room.where(room_status: "active")
    @subscriptions = Subscription.all

    @subscriptions.each do |subscription|
      mail(to: subscription.email, subject: "Weekly Room Update" )
    end
  end
end

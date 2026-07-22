class SubscriptionMailer < ApplicationMailer
  def new_room_notification(room)
    @room = room
    recipients = Subscription.pluck(:email).uniq
    mail(to: recipients, subject: "New Room Notification")
  end
end

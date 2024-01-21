class SubscriptionMailer < ApplicationMailer
  def new_room_notification(room)
    @room = room
    @subscriptions = Subscription.all

    @subscriptions.each do |subscription|
      mail(to: subscription.email, subject: "New Room Notification")
    end
  end
end

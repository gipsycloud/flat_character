# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
  def new_room_notification
    room = Room.first
    user = User.first
    SubscriptionMailer.with(user: user).new_room_notification(room)
  end
end

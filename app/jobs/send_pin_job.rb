class SendPinJob < ApplicationJob
  # queue_as :default

  def perform(user)
    user.reset_pin!                           # Reset the user's verification PIN
    user.update(pin_sent_at: Time.now)        # Update the timestamp when the PIN was sent
    UserMailer.send_pin(user).deliver_now     # Send the PIN email using the UserMailer
  end
end

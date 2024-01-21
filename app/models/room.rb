class Room < ApplicationRecord
  after_create :notify_subscribers

  belongs_to :user, class_name: 'User', foreign_key: :user_id, optional: true

  def notify_subscribers
    SubscriptionMailer.new_room_notification(self).deliver_now
  end

end

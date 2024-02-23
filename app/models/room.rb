require 'uri'

class Room < ApplicationRecord
  mount_uploader :image, RoomPhotoUploader
  after_create :notify_subscribers
  belongs_to :user, class_name: 'User', foreign_key: :user_id, optional: true

  enum gender_num: { male: 1, female: 2 }
  enum room_status_num: { active: 1, inactive: 2 }

  def notify_subscribers
    SubscriptionMailer.new_room_notification(self).deliver_now
  end

end

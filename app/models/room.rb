require 'uri'

class Room < ApplicationRecord
  extend FriendlyId
  friendly_id :roomType, use: :slugged
  mount_uploader :image, RoomPhotoUploader
  after_create :notify_subscribers
  belongs_to :user, class_name: 'User', foreign_key: :user_id, optional: true
  # normalizes :slug, with: -> slug { slug.titlesize }

  enum gender_num: { male: 1, female: 2 }
  enum room_status_num: { active: 1, inactive: 2 }

  has_many :room_images, :dependent => :destroy
  accepts_nested_attributes_for :room_images, allow_destroy: true

  def notify_subscribers
    SubscriptionMailer.new_room_notification(self).deliver_now
  end

end

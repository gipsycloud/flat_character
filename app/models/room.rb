require 'uri'

class Room < ApplicationRecord
  extend FriendlyId
  friendly_id :roomType, use: :slugged
  mount_uploader :image, RoomPhotoUploader
  geocoded_by :address
  # after_validation :geocode
  after_validation :geocode, if: :address_changed?
  after_create_commit :notify_subscribers
  belongs_to :user, class_name: 'User', foreign_key: :user_id, optional: true
  # normalizes :slug, with: -> slug { slug.titlesize }

  enum :gender, { male: "male", female: "female", couple: "couple", siblings: "siblings" }
  enum :roomType, { single_family: "single_family", apartment: "apartment", condo: "condo", duplex: "duplex" }
  enum :room_status, { active: "active", inactive: "inactive" }

  # Compatibility names used by the existing form helpers.
  def self.gender_nums
    genders
  end

  def self.room_type_nums
    roomTypes
  end

  def self.room_status_nums
    room_statuses
  end

  has_one :property, class_name: 'Property', foreign_key: :room_id
  has_many :room_images, :dependent => :destroy
  accepts_nested_attributes_for :room_images, allow_destroy: true


  # validate :validate_imageslatitude

  # def address
  #   [street, city, zip, state].compact.join(" , ")
  # end

  # def address_change?
  #   [stree, city, zip, state].compact.join( " " )
  # end

  def notify_subscribers
    SubscriptionMailer.new_room_notification(self).deliver_later
  end

  private
  def validate_images
    return if room_image.count <= 4

    errors.add(:room_image, "You can upload max 4 images !!")
  end

end

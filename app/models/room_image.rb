class RoomImage < ApplicationRecord
  mount_uploader :room_image, RoomPhotoUploader
  belongs_to :room

  # validates :room_image, presence: true
end

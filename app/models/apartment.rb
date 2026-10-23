class Apartment < ApplicationRecord
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :favoriting_users, through: :favorites, source: :user

  enum :lifestyle_mode, { calm: 0, balanced: 1, energetic: 2 }
  enum :status, { available: 0, occupied: 1, hidden: 2 }

  validates :title, :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  scope :available_now, -> { where(status: :available) }
end

# belongs_to :user = the user who posted the listing. If apartments are admin-managed in your app, keep the column but make the association optional: true (shown below).
# Optional — photos: bin/rails active_storage:install && bin/rails db:migrate, then uncomment the has_many_attached :photos line. Easy to add later.
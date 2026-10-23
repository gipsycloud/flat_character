class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :apartment

  validates :apartment_id, uniqueness: { scope: :user_id }
end

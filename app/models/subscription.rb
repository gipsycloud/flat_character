class Subscription < ApplicationRecord
  belongs_to :user, foreign_key: :email, primary_key: :email

  validates :email, presence: true, uniqueness: true
  # belongs_to :user
end

class Subscription < ApplicationRecord
  belongs_to :user, foreign_key: :email, primary_key: :email
  # belongs_to :user
end

class Property < ApplicationRecord
  belongs_to :room, foreign_key: :room_id
end

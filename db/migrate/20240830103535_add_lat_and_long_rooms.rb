class AddLatAndLongRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :latitude, :float
    add_column :rooms, :longitude, :float
  end
end

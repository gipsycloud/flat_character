class CreateRoomImages < ActiveRecord::Migration[7.0]
  def change
    create_table :room_images do |t|
      t.integer :room_id
      t.string :room_image
      t.timestamps
    end
  end
end

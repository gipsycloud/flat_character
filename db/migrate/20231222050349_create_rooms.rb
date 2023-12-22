class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :roomType
      t.integer :maxPersons
      t.string :roomPrice
      t.string :gender
      t.integer :roomNumber
      t.text :details
      t.datetime :startDate
      t.datetime :endDate
      t.string :floor
      t.string :address
      t.string :room_status
      t.string :feedback

      t.timestamps
    end
  end
end

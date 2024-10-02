class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.string :cupon_code
      t.string :discount_amount
      t.string :tax
      t.string :phone_number
      t.string :room_price
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end

class CreateApartments < ActiveRecord::Migration[8.0]
  def change
    create_table :apartments do |t|
      t.references :user, foreign_key: true        # who posted it (see note below)
      t.string   :title, null: false
      t.text     :description
      t.string   :address, null: false
      t.string   :city
      t.decimal  :latitude,  precision: 10, scale: 6   # needed for job matching!
      t.decimal  :longitude, precision: 10, scale: 6
      t.decimal  :monthly_rent, precision: 10, scale: 2
      t.string   :currency, default: "USD"
      t.integer  :bedrooms, default: 1
      t.integer  :bathrooms, default: 1
      t.integer  :size_m2
      t.integer  :lifestyle_mode, default: 0, null: false  # 0 calm, 1 balanced, 2 energetic
      t.integer  :status, default: 0, null: false          # 0 available, 1 occupied, 2 hidden
      t.date     :available_from
      t.timestamps
    end
    add_index :apartments, :lifestyle_mode
    add_index :apartments, :status
  end
end

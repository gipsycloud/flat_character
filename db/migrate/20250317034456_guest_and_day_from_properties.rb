class GuestAndDayFromProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :guest_count, :string
    add_column :properties, :day_count, :string
    add_column :properties, :service_fee, :string
    add_column :properties, :cleaning_fee, :string
    add_column :properties, :rent_service, :string
  end
end

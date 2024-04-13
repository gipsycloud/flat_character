class AddExpiryToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :exp_year, :string
    add_column :payments, :exp_month, :string
  end
end

class AddExtraInfoToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :card_holder_name, :string
    add_column :payments, :card_number, :string
    add_column :payments, :cvc, :string
    add_column :payments, :billing_address, :string
  end
end

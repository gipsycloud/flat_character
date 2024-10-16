class TotalAmountFromProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :total_amount, :string
  end
end

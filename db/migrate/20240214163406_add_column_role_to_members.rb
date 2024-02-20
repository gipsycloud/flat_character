class AddColumnRoleToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :role, :integer
  end
end

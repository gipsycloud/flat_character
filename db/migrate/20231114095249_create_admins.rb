class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :admin_email
      t.string :admin_name
      t.string :admin_phone_number
      t.string :admin_roles
      t.string :status
      t.datetime :last_login
      t.timestamps
    end
  end
end

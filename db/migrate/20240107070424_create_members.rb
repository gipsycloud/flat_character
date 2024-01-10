class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :memberName
      t.string :email
      t.string :phoneNumber
      t.string :memberAddress
      t.datetime :joinDate
      t.datetime :lastLogin
      t.string  :memberType
      t.references :room, foreign_key: true
      t.timestamps
    end
  end
end

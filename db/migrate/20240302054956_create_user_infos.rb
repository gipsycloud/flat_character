class CreateUserInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_infos do |t|
      t.references :user, foreign_key: true
      t.string :job_type
      t.text :details
      t.string :plan
      t.string :hobby, array: true, default: []
      t.string :favourite
      t.string :facebook_link
      t.string :instagram
      t.string :twitter
      t.string :linkedin
      
      t.timestamps
    end
  end
end

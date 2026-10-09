class SavedJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :saved_jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_listing, null: false, foreign_key: true
      t.integer :status, null: false, default: 0    # 0 saved, 1 applied, 2 archived
      t.timestamps
    end
    add_index :saved_jobs, [:user_id, :job_listing_id], unique: true
  end
end

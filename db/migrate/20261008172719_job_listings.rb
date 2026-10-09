class JobListings < ActiveRecord::Migration[7.2]
  def change
    create_table :job_listings do |t|
      t.string :title, null: false
      t.string :company, null: false
      t.string :location, null: false
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :salary_min
      t.integer :salary_max
      t.string :salary_currency
      t.integer :employment_type
      t.integer :experience_level
      t.integer :remote_status
      t.string :currency, default: "USD"
      t.text :description
      t.string :source_url, null: false
      t.string :url_digest, null: false     # SHA256 of source_url → dedup
      t.datetime :posted_at
      t.datetime :expires_at
      t.integer :status, null: false, default: 0    # 0 active, 1 inactive, 2 expired
      t.jsonb :metadata, null: false, default: {}
      t.references :job_category, foreign_key: true
      t.references :job_source, foreign_key: true
      t.timestamps
    end
  end
end

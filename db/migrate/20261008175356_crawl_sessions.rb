class CrawlSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :crawl_sessions do |t|
      t.references :job_source, null: false, foreign_key: true
      t.integer :job_count, null: false, default: 0
      t.integer :listings_found, default: 0
      t.integer :listings_created, default: 0
      t.integer :listings_updated, default: 0
      t.datetime :started_at, null: false
      t.datetime :finished_at
      t.integer :status, null: false, default: 0    # 0 pending, 1 in_progress, 2 completed, 3 failed
      t.text :error_message
      t.timestamps
    end
  end
end

class JobCrawler < ActiveRecord::Migration[7.2]
  def change
    create_table :job_sources do |t|
      t.string :name, null: false
      t.string :base_url, null: false
      t.string :crawler_class, null: false
      t.jsonb :config, null: false, default: {}
      t.boolean :active, null: false, default: true
      t.integer :crawl_interval, null: false, default: 60
      t.datetime :last_crawled_at
      t.timestamps
    end
  end
end

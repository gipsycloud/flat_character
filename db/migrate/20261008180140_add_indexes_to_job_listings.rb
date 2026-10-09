class AddIndexesToJobListings < ActiveRecord::Migration[7.2]
  def change
    add_index :job_listings, :url_digest, unique: true
    add_index :job_listings, :location
  end
end

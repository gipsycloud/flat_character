class MakeUrlDigestIndexUnique < ActiveRecord::Migration[8.0]
  def up
    url_digest_indexes = indexes(:job_listings).select do |index|
      index.columns == ["url_digest"]
    end

    return if url_digest_indexes.any?(&:unique)

    url_digest_indexes.each do |index|
      remove_index :job_listings, name: index.name
    end

    add_index :job_listings, :url_digest, unique: true
  end

  def down
    url_digest_indexes = indexes(:job_listings).select do |index|
      index.columns == ["url_digest"]
    end

    url_digest_indexes.each do |index|
      remove_index :job_listings, name: index.name
    end

    add_index :job_listings, :url_digest
  end
end

# - Detects indexes by columns rather than assuming the default name.
# - Avoids recreating an existing unique index.
# - Removes conflicting indexes before adding the unique one.
# - Adds a reversible down migration

# rails runner 'ActiveRecord::Base.connection.indexes(:job_listings).each { |i| puts "#{i.name} | cols: #{i.columns.join(",")} | unique: #{i.unique}" }'
# index_job_listings_on_job_category_id | cols: job_category_id | unique: false
# index_job_listings_on_job_source_id | cols: job_source_id | unique: false
# index_job_listings_on_url_digest | cols: url_digest | unique: true
class JobCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :job_categories do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :job_categories, :name, unique: true
  end
end

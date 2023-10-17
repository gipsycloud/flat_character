class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :post_title
      t.string :post_body
      t.timestamps
    end
  end
end

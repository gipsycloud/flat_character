class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :article_title
      t.string :article_content
      t.string :article_image
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

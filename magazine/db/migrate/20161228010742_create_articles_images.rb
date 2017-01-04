class CreateArticlesImages < ActiveRecord::Migration
  def change
    create_table :articles_images do |t|
      t.references :article, index: true, foreign_key: true
      t.references :image, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

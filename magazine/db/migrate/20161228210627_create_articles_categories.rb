class CreateArticlesCategories < ActiveRecord::Migration
  def change
    create_table :articles_categories do |t|
      t.references :article, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

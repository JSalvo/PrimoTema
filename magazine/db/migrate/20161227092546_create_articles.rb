class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :creation_date     

      t.timestamps null: false
    end
  end
end

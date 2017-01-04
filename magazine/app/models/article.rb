class Article < ActiveRecord::Base
	has_many :paragraphs, dependent: :destroy
	has_many :articles_images, dependent: :destroy
	has_many :images, through: :articles_images
	has_many :articles_categories, dependent: :destroy
	has_many :categories, through: :articles_categories
	has_many :comments, dependent: :destroy
end

class ArticlesImage < ActiveRecord::Base
  belongs_to :article
  belongs_to :image
end

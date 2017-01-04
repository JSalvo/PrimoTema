json.extract! article, :id, :title, :creation_date, :image, :body, :created_at, :updated_at
json.url article_url(article, format: :json)
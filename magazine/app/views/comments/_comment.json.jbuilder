json.extract! comment, :id, :body, :name, :email, :url_site, :article_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
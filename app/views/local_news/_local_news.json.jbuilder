json.extract! local_news, :id, :title, :extrait, :statut, :created_at, :updated_at
json.url local_news_url(local_news, format: :json)

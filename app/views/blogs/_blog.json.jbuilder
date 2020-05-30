json.extract! blog, :id, :title, :categorie, :student_can_read, :user_id, :created_at, :updated_at
json.url blog_url(blog, format: :json)

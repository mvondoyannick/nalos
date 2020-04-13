json.extract! course, :id, :title, :chapter, :extrait, :salle_de_class_id, :filiere_id, :created_at, :updated_at
json.url course_url(course, format: :json)

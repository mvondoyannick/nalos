json.extract! e_response, :id, :epreuve_id, :student_id, :user_id, :salle_de_class_id, :created_at, :updated_at
json.url e_response_url(e_response, format: :json)

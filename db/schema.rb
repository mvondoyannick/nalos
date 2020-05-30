# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_29_183504) do

  create_table "action_text_rich_texts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "classe_matieres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "salle_de_class_id", null: false
    t.bigint "matiere_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matiere_id"], name: "index_classe_matieres_on_matiere_id"
    t.index ["salle_de_class_id"], name: "index_classe_matieres_on_salle_de_class_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.boolean "read"
    t.bigint "user_id"
    t.string "metakey"
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["student_id"], name: "index_comments_on_student_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "course_statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "chapter"
    t.bigint "salle_de_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "synthese"
    t.bigint "matiere_id"
    t.string "tag"
    t.string "categorie"
    t.integer "counter"
    t.bigint "document_id"
    t.string "file"
    t.datetime "start_time"
    t.bigint "course_status_id", null: false
    t.integer "file_id"
    t.string "token"
    t.index ["course_status_id"], name: "index_courses_on_course_status_id"
    t.index ["document_id"], name: "index_courses_on_document_id"
    t.index ["matiere_id"], name: "index_courses_on_matiere_id"
    t.index ["salle_de_class_id"], name: "index_courses_on_salle_de_class_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "cycle_ecoles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "detail"
    t.bigint "structure_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["structure_id"], name: "index_cycle_ecoles_on_structure_id"
  end

  create_table "documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "enseignements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "epreuves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title"
    t.bigint "salle_de_class_id", null: false
    t.bigint "matiere_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["matiere_id"], name: "index_epreuves_on_matiere_id"
    t.index ["salle_de_class_id"], name: "index_epreuves_on_salle_de_class_id"
    t.index ["user_id"], name: "index_epreuves_on_user_id"
  end

  create_table "filieres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "local_news", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title"
    t.string "extrait"
    t.string "statut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lorems", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matieres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "descriptioin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.bigint "structure_id"
    t.index ["structure_id"], name: "index_matieres_on_structure_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "subject"
    t.bigint "student_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_messages_on_student_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "problemes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.index ["student_id"], name: "index_problemes_on_student_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salle_de_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.integer "effectif"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cycle_ecole_id"
    t.string "token"
    t.bigint "structure_id"
    t.index ["cycle_ecole_id"], name: "index_salle_de_classes_on_cycle_ecole_id"
    t.index ["structure_id"], name: "index_salle_de_classes_on_structure_id"
  end

  create_table "statistics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "counter"
    t.bigint "course_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_statistics_on_course_id"
    t.index ["student_id"], name: "index_statistics_on_student_id"
  end

  create_table "structures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "slogan"
    t.integer "mobile"
    t.integer "fixe"
    t.string "pays"
    t.string "region"
    t.date "creation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
  end

  create_table "students", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "second_name"
    t.string "sexe"
    t.string "phone"
    t.string "matricule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "salle_de_class_id"
    t.integer "structure"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
    t.index ["salle_de_class_id"], name: "index_students_on_salle_de_class_id"
  end

  create_table "teacher_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "salle_de_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "matiere_id"
    t.index ["matiere_id"], name: "index_teacher_classes_on_matiere_id"
    t.index ["salle_de_class_id"], name: "index_teacher_classes_on_salle_de_class_id"
    t.index ["user_id"], name: "index_teacher_classes_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "second_name"
    t.string "matricule"
    t.date "date_naissance"
    t.string "lieu_naissance"
    t.string "cni"
    t.string "sexe"
    t.string "phone1"
    t.string "phone2"
    t.string "password"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "structure_id", null: false
    t.bigint "cycle_ecole_id"
    t.bigint "salle_de_class_id"
    t.string "token"
    t.string "statut"
    t.boolean "deleted"
    t.index ["cycle_ecole_id"], name: "index_users_on_cycle_ecole_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["salle_de_class_id"], name: "index_users_on_salle_de_class_id"
    t.index ["structure_id"], name: "index_users_on_structure_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "classe_matieres", "matieres"
  add_foreign_key "classe_matieres", "salle_de_classes"
  add_foreign_key "comments", "courses"
  add_foreign_key "comments", "students"
  add_foreign_key "comments", "users"
  add_foreign_key "courses", "course_statuses"
  add_foreign_key "courses", "documents"
  add_foreign_key "courses", "matieres"
  add_foreign_key "courses", "salle_de_classes"
  add_foreign_key "courses", "users"
  add_foreign_key "cycle_ecoles", "structures"
  add_foreign_key "documents", "users"
  add_foreign_key "epreuves", "matieres"
  add_foreign_key "epreuves", "salle_de_classes"
  add_foreign_key "epreuves", "users"
  add_foreign_key "matieres", "structures"
  add_foreign_key "messages", "students"
  add_foreign_key "messages", "users"
  add_foreign_key "problemes", "students"
  add_foreign_key "salle_de_classes", "cycle_ecoles"
  add_foreign_key "salle_de_classes", "structures"
  add_foreign_key "statistics", "courses"
  add_foreign_key "statistics", "students"
  add_foreign_key "students", "salle_de_classes"
  add_foreign_key "teacher_classes", "matieres"
  add_foreign_key "teacher_classes", "salle_de_classes"
  add_foreign_key "teacher_classes", "users"
  add_foreign_key "users", "cycle_ecoles"
  add_foreign_key "users", "salle_de_classes"
  add_foreign_key "users", "structures"
end

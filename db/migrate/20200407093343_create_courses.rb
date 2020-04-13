class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :chapter
      t.string :extrait
      t.references :salle_de_class, null: false, foreign_key: true
      t.references :filiere, null: false, foreign_key: true

      t.timestamps
    end
  end
end

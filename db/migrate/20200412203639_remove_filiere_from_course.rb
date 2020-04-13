class RemoveFiliereFromCourse < ActiveRecord::Migration[6.0]
  def change
    remove_reference :courses, :filiere, null: false, foreign_key: true
  end
end

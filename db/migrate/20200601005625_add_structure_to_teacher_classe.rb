class AddStructureToTeacherClasse < ActiveRecord::Migration[6.0]
  def change
    add_reference :teacher_classes, :structure, null: true, foreign_key: true
  end
end

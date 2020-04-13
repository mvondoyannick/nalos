class CreateTeacherClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_classes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :salle_de_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end

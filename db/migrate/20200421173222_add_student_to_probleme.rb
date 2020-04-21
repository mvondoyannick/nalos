class AddStudentToProbleme < ActiveRecord::Migration[6.0]
  def change
    add_reference :problemes, :student, null: true, foreign_key: true
  end
end

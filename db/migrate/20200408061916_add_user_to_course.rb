class AddUserToCourse < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :user, null: true, foreign_key: true
    add_column :courses, :synthese, :string
    add_reference :courses, :matiere, null: true, foreign_key: true
  end
end

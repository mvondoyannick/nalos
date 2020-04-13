class AddFiliereToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :filiere, null: true, foreign_key: true
  end
end

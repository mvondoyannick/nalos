class AddFiliereToMatiere < ActiveRecord::Migration[6.0]
  def change
    add_reference :matieres, :filiere, null: true, foreign_key: true
  end
end

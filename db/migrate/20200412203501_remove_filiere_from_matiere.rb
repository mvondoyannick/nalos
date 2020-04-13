class RemoveFiliereFromMatiere < ActiveRecord::Migration[6.0]
  def change
    remove_reference :matieres, :filiere, null: false, foreign_key: true
  end
end

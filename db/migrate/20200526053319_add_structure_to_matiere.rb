class AddStructureToMatiere < ActiveRecord::Migration[6.0]
  def change
    add_reference :matieres, :structure, null: true, foreign_key: true
  end
end

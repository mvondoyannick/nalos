class AddStructureToFiliere < ActiveRecord::Migration[6.0]
  def change
    add_reference :filieres, :structure, null: true, foreign_key: true
  end
end

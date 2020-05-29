class AddStructureToSalleDeClass < ActiveRecord::Migration[6.0]
  def change
    add_reference :salle_de_classes, :structure, null: true, foreign_key: true
  end
end

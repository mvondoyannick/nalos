class AddCycleEcoleToSalleDeClass < ActiveRecord::Migration[6.0]
  def change
    add_reference :salle_de_classes, :cycle_ecole, null: true, foreign_key: true
  end
end

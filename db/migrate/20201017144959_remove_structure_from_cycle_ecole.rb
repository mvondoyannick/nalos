class RemoveStructureFromCycleEcole < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cycle_ecoles, :structure, null: false, foreign_key: true
  end
end

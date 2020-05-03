class RemoveStructureFromCycle < ActiveRecord::Migration[6.0]
  def change
    # remove_reference :cycles, :structure, null: false, foreign_key: true
  end
end

class AddStructureToYr < ActiveRecord::Migration[6.0]
  def change
    add_reference :yrs, :structure, null: true, foreign_key: true
  end
end

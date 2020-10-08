class AddStructureToYr < ActiveRecord::Migration[6.0]
  def change
    add_reference :yrs, :structure, null: false, foreign_key: true
  end
end

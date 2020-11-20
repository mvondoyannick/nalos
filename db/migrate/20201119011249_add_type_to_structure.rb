class AddTypeToStructure < ActiveRecord::Migration[6.0]
  def change
    add_reference :structures, :structure_type, null: true, foreign_key: true
  end
end

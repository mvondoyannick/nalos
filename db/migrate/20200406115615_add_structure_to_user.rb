class AddStructureToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :structure, null: false, foreign_key: true
  end
end

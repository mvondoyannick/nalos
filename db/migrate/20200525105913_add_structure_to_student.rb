class AddStructureToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :structure, :integer
  end
end

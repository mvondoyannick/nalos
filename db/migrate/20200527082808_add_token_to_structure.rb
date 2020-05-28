class AddTokenToStructure < ActiveRecord::Migration[6.0]
  def change
    add_column :structures, :token, :string
  end
end

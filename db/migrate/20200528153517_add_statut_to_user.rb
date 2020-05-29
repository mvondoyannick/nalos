class AddStatutToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :statut, :string
  end
end

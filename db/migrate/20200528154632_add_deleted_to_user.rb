class AddDeletedToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deleted, :boolean
  end
end

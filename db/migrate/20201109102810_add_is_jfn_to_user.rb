class AddIsJfnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_jfn, :boolean
  end
end

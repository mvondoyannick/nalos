class AddReadToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :read, :boolean
  end
end

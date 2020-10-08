class AddTokenToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :token, :string
  end
end

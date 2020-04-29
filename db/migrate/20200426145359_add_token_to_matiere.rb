class AddTokenToMatiere < ActiveRecord::Migration[6.0]
  def change
    add_column :matieres, :token, :string
  end
end

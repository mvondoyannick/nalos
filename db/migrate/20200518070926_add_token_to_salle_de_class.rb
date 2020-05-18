class AddTokenToSalleDeClass < ActiveRecord::Migration[6.0]
  def change
    add_column :salle_de_classes, :token, :string
  end
end

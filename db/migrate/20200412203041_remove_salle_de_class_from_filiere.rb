class RemoveSalleDeClassFromFiliere < ActiveRecord::Migration[6.0]
  def change
    remove_reference :filieres, :salle_de_class, null: false, foreign_key: true
  end
end

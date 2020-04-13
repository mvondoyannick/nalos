class RemoveCycleFromSalleDeClass < ActiveRecord::Migration[6.0]
  def change
    remove_reference :salle_de_classes, :cycle, null: false, foreign_key: true
  end
end

class AddSalleDeClassToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :salle_de_class, null: true, foreign_key: true
  end
end

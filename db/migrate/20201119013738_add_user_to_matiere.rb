class AddUserToMatiere < ActiveRecord::Migration[6.0]
  def change
    add_reference :matieres, :user, null: true, foreign_key: true
  end
end

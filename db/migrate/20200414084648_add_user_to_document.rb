class AddUserToDocument < ActiveRecord::Migration[6.0]
  def change
    add_reference :documents, :user, null: true, foreign_key: true
  end
end

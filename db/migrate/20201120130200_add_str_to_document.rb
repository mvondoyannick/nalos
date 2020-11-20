class AddStrToDocument < ActiveRecord::Migration[6.0]
  def change
    add_reference :documents, :structure, null: false, foreign_key: true
  end
end

class AddStructureToDocument < ActiveRecord::Migration[6.0]
  def change
    add_reference :documents, :document, null: true, foreign_key: true
  end
end

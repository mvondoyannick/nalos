class AddDocumentToCourse < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :document, null: true, foreign_key: true
  end
end

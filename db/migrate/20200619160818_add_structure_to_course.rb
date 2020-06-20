class AddStructureToCourse < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :structure, null: true, foreign_key: true
  end
end

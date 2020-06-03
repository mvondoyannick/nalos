class AddDeletedToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :deleted, :boolean
  end
end

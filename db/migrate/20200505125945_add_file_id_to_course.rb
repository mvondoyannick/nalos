class AddFileIdToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :file_id, :integer
  end
end

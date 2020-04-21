class AddFileToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :file, :string
  end
end

class RemoveTitleFromCourse < ActiveRecord::Migration[6.0]
  def change

    remove_column :courses, :title, :string
  end
end

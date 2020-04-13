class RemoveExtraitFromCourse < ActiveRecord::Migration[6.0]
  def change

    remove_column :courses, :extrait, :string
  end
end

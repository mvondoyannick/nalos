class AddTagToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :tag, :string
  end
end

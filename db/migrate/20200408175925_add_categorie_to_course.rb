class AddCategorieToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :categorie, :string
  end
end

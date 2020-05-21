class AddTokenToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :token, :string
  end
end

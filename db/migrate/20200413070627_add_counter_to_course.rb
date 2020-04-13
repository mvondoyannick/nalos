class AddCounterToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :counter, :integer
  end
end

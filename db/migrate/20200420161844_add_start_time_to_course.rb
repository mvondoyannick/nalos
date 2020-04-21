class AddStartTimeToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :start_time, :datetime
  end
end

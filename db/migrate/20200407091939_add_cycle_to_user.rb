class AddCycleToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :cycle, null: true, foreign_key: true
  end
end

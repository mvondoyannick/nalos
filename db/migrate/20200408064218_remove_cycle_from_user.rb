class RemoveCycleFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :cycle, null: false, foreign_key: true
  end
end

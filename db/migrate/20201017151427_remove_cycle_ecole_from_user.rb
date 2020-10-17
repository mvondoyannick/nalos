class RemoveCycleEcoleFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_reference :users, :cycle_ecole, null: false, foreign_key: true
  end
end

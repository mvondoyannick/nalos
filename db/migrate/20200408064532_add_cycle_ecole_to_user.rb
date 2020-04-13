class AddCycleEcoleToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :cycle_ecole, null: true, foreign_key: true
  end
end

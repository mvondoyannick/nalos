class CreateCycleEcoles < ActiveRecord::Migration[6.0]
  def change
    create_table :cycle_ecoles do |t|
      t.string :name
      t.string :code
      t.string :detail
      t.references :structure, null: false, foreign_key: true

      t.timestamps
    end
  end
end

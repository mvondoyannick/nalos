class CreateTrs < ActiveRecord::Migration[6.0]
  def change
    create_table :trs do |t|
      t.string :name
      t.string :debut
      t.string :fin
      t.references :yr, null: false, foreign_key: true

      t.timestamps
    end
  end
end

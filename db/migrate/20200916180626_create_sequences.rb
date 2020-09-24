class CreateSequences < ActiveRecord::Migration[6.0]
  def change
    create_table :sequences do |t|
      t.string :name
      t.date :date_debut
      t.date :date_fin
      t.references :trimestre, null: false, foreign_key: true

      t.timestamps
    end
  end
end

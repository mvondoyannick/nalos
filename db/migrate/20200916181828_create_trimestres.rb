class CreateTrimestres < ActiveRecord::Migration[6.0]
  def change
    create_table :trimestres do |t|
      t.string :name
      t.date :date_debut
      t.date :date_fin
      t.references :annne_scolaire, null: false, foreign_key: true

      t.timestamps
    end
  end
end

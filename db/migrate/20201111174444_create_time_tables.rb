class CreateTimeTables < ActiveRecord::Migration[6.0]
  def change
    create_table :time_tables do |t|
      t.string :periode_debut
      t.string :periode_fin
      t.references :filiere, null: false, foreign_key: true
      t.references :salle_de_class, null: false, foreign_key: true
      t.references :structure, null: false, foreign_key: true

      t.timestamps
    end
  end
end

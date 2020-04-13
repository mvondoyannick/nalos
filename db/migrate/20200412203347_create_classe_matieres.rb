class CreateClasseMatieres < ActiveRecord::Migration[6.0]
  def change
    create_table :classe_matieres do |t|
      t.references :salle_de_class, null: false, foreign_key: true
      t.references :matiere, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateEpreuves < ActiveRecord::Migration[6.0]
  def change
    create_table :epreuves do |t|
      t.string :title
      t.references :salle_de_class, null: false, foreign_key: true
      t.references :matiere, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

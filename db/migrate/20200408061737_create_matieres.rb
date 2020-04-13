class CreateMatieres < ActiveRecord::Migration[6.0]
  def change
    create_table :matieres do |t|
      t.string :name
      t.string :descriptioin
      t.references :filiere, null: true, foreign_key: true

      t.timestamps
    end
  end
end

class CreateFilieres < ActiveRecord::Migration[6.0]
  def change
    create_table :filieres do |t|
      t.string :name
      t.string :content
      t.references :salle_de_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end

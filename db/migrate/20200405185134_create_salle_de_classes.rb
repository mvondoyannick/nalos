class CreateSalleDeClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :salle_de_classes do |t|
      t.string :name
      t.integer :effectif
      t.references :cycle, null: false, foreign_key: true

      t.timestamps
    end
  end
end

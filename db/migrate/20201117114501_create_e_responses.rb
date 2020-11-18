class CreateEResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :e_responses do |t|
      t.references :epreuve, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :salle_de_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end

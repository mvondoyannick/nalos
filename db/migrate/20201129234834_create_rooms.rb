class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :vonage_session_id
      t.references :user, null: false, foreign_key: true
      t.references :salle_de_class, null: false, foreign_key: true
      t.references :filiere, null: false, foreign_key: true

      t.timestamps
    end
  end
end

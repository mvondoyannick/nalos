class CreateStructures < ActiveRecord::Migration[6.0]
  def change
    create_table :structures do |t|
      t.string :name
      t.string :email
      t.string :slogan
      t.integer :mobile
      t.integer :fixe
      t.string :pays
      t.string :region
      t.date :creation

      t.timestamps
    end
  end
end

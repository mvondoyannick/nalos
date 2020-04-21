class CreateLorems < ActiveRecord::Migration[6.0]
  def change
    create_table :lorems do |t|
      t.string :name
      t.string :age

      t.timestamps
    end
  end
end

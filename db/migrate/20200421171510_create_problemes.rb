class CreateProblemes < ActiveRecord::Migration[6.0]
  def change
    create_table :problemes do |t|
      t.string :title

      t.timestamps
    end
  end
end

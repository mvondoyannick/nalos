class CreateYrs < ActiveRecord::Migration[6.0]
  def change
    create_table :yrs do |t|
      t.string :name

      t.timestamps
    end
  end
end

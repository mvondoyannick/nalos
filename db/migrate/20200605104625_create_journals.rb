class CreateJournals < ActiveRecord::Migration[6.0]
  def change
    create_table :journals do |t|
      t.string :browser
      t.string :token
      t.string :ip
      t.string :controller
      t.string :action
      t.datetime :date

      t.timestamps
    end
  end
end

class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.string :email
      t.string :token
      t.string :ip
      t.string :last_session
      t.integer :counter

      t.timestamps
    end
  end
end

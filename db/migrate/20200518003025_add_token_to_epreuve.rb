class AddTokenToEpreuve < ActiveRecord::Migration[6.0]
  def change
    add_column :epreuves, :token, :string
  end
end

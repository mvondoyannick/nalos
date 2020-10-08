class AddEndToYr < ActiveRecord::Migration[6.0]
  def change
    add_column :yrs, :end, :string
  end
end

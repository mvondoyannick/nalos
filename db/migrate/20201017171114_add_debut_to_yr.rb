class AddDebutToYr < ActiveRecord::Migration[6.0]
  def change
    add_column :yrs, :debut, :date
  end
end

class AddMetakeyToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :metakey, :string
  end
end

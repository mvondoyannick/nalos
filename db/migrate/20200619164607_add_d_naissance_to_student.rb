class AddDNaissanceToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :d_naissance, :string
    add_column :students, :l_naissance, :string
  end
end

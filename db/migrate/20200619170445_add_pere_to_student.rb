class AddPereToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :pere, :string
    add_column :students, :c_pere, :string
    add_column :students, :f_pere, :string
    add_column :students, :mere, :string
    add_column :students, :c_mere, :string
    add_column :students, :f_mere, :string
    add_column :students, :tuteur, :string
    add_column :students, :c_tuteur, :string
    add_column :students, :c_autre, :string
  end
end

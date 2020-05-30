class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :categorie
      t.boolean :student_can_read
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

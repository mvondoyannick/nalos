class CreateJfnSupportCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :jfn_support_courses do |t|
      t.string :title
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

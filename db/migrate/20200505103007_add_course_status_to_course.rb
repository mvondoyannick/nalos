class AddCourseStatusToCourse < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :course_status, null: false, foreign_key: true
  end
end

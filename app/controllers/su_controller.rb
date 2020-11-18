class SuController < ApplicationController

  def index
  end

  def etablissements
    @structures = Structure.all
  end

  def wait_structures_courses
    @strs = Course.where(course_status_id: CourseStatus.find_by_name('waiting').id)
  end

  def wait_courses
    @courses = Course.where(course_status_id: CourseStatus.find_by_name('waiting').id)
  end

  def teachers
    @structure = Structure.find_by_token(params[:token])
    @teachers = User.where(role_id: Role.find_by_name('teacher').id, structure_id: @structure)
  end

  def students
    @structure = Structure.find_by_token(params[:token])
    @students = Student.where(structure: @structure.id)
  end
end

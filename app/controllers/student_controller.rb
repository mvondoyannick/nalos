class StudentController < ApplicationController
  before_action :authenticate_user!
  layout 'application'
  def index
  end

  def list
    @students = Student.where(structure: current_user.structure_id)
  end

  def import
  end
end

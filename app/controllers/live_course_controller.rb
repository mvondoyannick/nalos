class LiveCourseController < ApplicationController
  before_action :authenticate_user!
  def index
    @teacher_class = TeacherClasse.where(user_id: current_user.id).distinct
    @class_student = Student.where(salle_de_class_id: current_user.salle_de_class_id).count
  end

  def test_webrtc
    
  end
end

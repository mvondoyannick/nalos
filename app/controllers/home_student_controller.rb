class HomeStudentController < ApplicationController
  before_action :authenticate_student!
  before_action :update_course_counter, only: :read_course
  def index
    @last_course = Course.all.where(salle_de_class_id: current_student.salle_de_class_id) #Enseignement.last(10)
    @local_news = LocalNews.all
  end

  def dashboard
    
  end

  # student make comment
  def student_comment
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path, notice: 'Commentaire correctement publié' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # student read course
  def read_course

    current_course = params[:id]
    @css_class = "border-b-2"
    @current_course = Course.find(current_course)
  end

  def my_course
    @course = Course.all.where(filiere_id: current_student.filiere_id)
  end

  def exercice
    id = params[:id]
    @css_class = "border-b-2"
    @current_course = Course.find(id)
  end

  def synthese
    id = params[:id]
    @css_class = "border-b-2"
    @current_course = Course.find(id)
  end

  def documents
    id = params[:id]
    @css_class = "border-b-2"
    @current_course = Course.find(id)
  end

  def salle_de_classe
    @students = Student.all.where(salle_de_class_id: current_student.salle_de_class_id)
  end

  def student_course
    @course = Course.all.where(salle_de_class_id: current_student.salle_de_class_id)
  end

  def my_teachers

  end

  def my_teacher_course
    @courses = Course.where(user_id: params[:current_teacher], salle_de_class_id: current_student.salle_de_class_id)
  end

  # ressource de l'apprenant
  def student_ressources

  end

  # making chat with others teachers
  def discuss

  end

  # studenet timetable
  def time_table

  end

  private

  def update_course_counter
    Course.find(params[:id]).increment!(:counter)
  end

  def comment_params
    params.permit(:user_id, :course_id, :content)
  end
end

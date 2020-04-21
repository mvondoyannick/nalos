class HomeStudentController < ApplicationController
  before_action :authenticate_student!
  before_action :update_course_counter, only: :read_course
  def index
    @last_course = Course.all.where(salle_de_class_id: current_student.salle_de_class_id, course_status_id: 2) #Enseignement.last(10)
    @local_news = LocalNews.all
  end

  def dashboard
    
  end

  # student make comment
  def student_comment
    @comment = Comment.new(comment_params)

    if @comment.save
      puts "saved : #{@comment}"
      redirect_to read_course_path(course_key: params[:course_key], course_id: params[:course_id], id: params[:id]), notice: "Commentaire envoyé!"
    else
      puts "erorrs : #{@comment}"
      redirect_to read_course_path(course_key: params[:course_key], course_id: params[:course_id], id: params[:id]), notice: "Impossible de valide ce commentaire : #{@comment.errors.full_messages}"
    end

  end

  # student read course
  def read_course

    current_course = params[:id]
    @css_class = "border-b-2"
    @current_course = Course.find(params[:course_id])#Course.find(current_course)
    @current_file = Document.find(@current_course.document_id).file.find(@current_course.file_id)
  end

  def my_course
    @course = Course.all.where(filiere_id: current_student.filiere_id)
  end

  def exercice
    id = params[:course_id]
    @css_class = "border-b-2"
    @current_course = Course.find(id)
  end

  def synthese
    id = params[:course_id]
    @css_class = "border-b-2"
    @current_course = Course.find(id)
  end

  def documents
    id = params[:course_id]
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
    @courses = Course.where(user_id: params[:current_teacher], salle_de_class_id: current_student.salle_de_class_id, course_status_id: 2)
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
    Course.find(params[:course_id]).increment!(:counter)
  end

  def comment_params
    params.permit(:student_id, :user_id, :course_id, :content)
  end
end

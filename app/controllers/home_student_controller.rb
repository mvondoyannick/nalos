class HomeStudentController < ApplicationController
  before_action :authenticate_student!
  before_action :update_course_statitics, only: :read_course
  #load_and_authorize_resource
  
  def index
    @last_course = Course.where(salle_de_class_id: current_student.salle_de_class_id, course_status_id: CourseStatus.find_by_name("validate").id).order(created_at: :desc).page(params[:page]).per(12) #Enseignement.last(10)
    @local_news = LocalNews.all.page(params[:page]).per(5)
  end

  # open yelp help document
  def help
    file_name = "#{Rails.root}/user_guide.pdf"
    send_file(file_name, type: "application/pdf", disposition: "inline")
  end

  def dashboard
    @course_data = Statistic.where(student_id: current_student.id)
    @course_data_week = Statistic.where(student_id: current_student.id, created_at: Date.today.beginning_of_week..Date.today.end_of_week)
    @course_data_mois = Statistic.where(student_id: current_student.id, created_at: Date.today.beginning_of_month..Date.today.end_of_month)
    @course_data_year = Statistic.where(student_id: current_student.id, created_at: Date.today.beginning_of_year..Date.today.end_of_year)
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

  # read student matieres
  def read_matiere
    matiere_token = params[:matiere_id] # token

    # return all course from this matiere
    @last_course = Course.where(salle_de_class_id: current_student.salle_de_class_id, course_status_id: 2, matiere_id: Matiere.find_by_token(matiere_token).id)
  end

  # gestion des epreuves
  def student_epreuves
    @epreuves = Epreuve.where(salle_de_class_id: current_student.salle_de_class_id).page(params[:page]).per(10)
  end

  # read epreuves
  def read_epreuve
    @epreuve = Epreuve.find_by_token(params[:token])
  end

  # read epreuve response
  def read_response
    @epreuve_response = Epreuve.find_by_token(params[:token])
  end

  # gestion des matières de l'eleve
  def student_matires
    @current_matiere =ClasseMatiere.where(salle_de_class_id: current_student.salle_de_class_id)
  end

  # lister tous les cours d'une matiere
  def list_course
    @current_course = Course.where(matiere_id: params[:id], salle_de_class_id: current_student.salle_de_class_id, course_status_id: 2)
    @current_matiere = Matiere.find(params[:id])
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
    @students = Student.all.where(salle_de_class_id: current_student.salle_de_class_id).page(params[:page]).per(20)
  end

  # liste all cours from this student
  def student_course
    @course = Course.where(salle_de_class_id: current_student.salle_de_class_id, course_status_id: CourseStatus.find_by_name("validate").id).page(params[:page]).per(10)
  end

  # liste all file from this student courses
  def student_course_files
    @course_file = Course.where(salle_de_class_id: current_student.salle_de_class_id).page(params[:page]).per(10)
  end

  # read document file with their own ID
  def read_course_file
    document_id = params[:document_id]
    file_id = params[:file_id]
    @current_file = Document.find(document_id).file.find(file_id)
  end

  def my_teachers
    @teachers = User.all.where(role_id: 1).page(params[:page]).per(5)
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

  # ressource document
  def ressource_document

  end

  # ressrouce exercice
  def ressource_exercice

  end

  # ressource epreuve
  def ressource_epreuve
    
  end

  private

  def update_course_counter
    Course.find(params[:course_id]).increment!(:counter)
  end

  def update_course_statitics
    #Statistic.where(course_id: params[:course_id], student_id: current_student.id).first_or_create(counter: 0).increment!(:counter) #new(course_id: params[:course_id, student_id: current_student.id, ])
    # new approche
    Statistic.new(course_id: params[:course_id], student_id: current_student.id, counter: 1).save
  end

  def comment_params
    params.permit(:student_id, :user_id, :course_id, :content)
  end

end

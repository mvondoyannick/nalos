class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    puts "welcome"
    @current_course = Course.where(user_id: current_user.id).order(created_at: :asc)
    @local_news = LocalNews.all.order(created_at: :desc)
  end

  def dashboard

  end

  def discuss
    
  end

  def apprenants
    @apprenant = Student.all.where(salle_de_class_id: current_user.salle_de_class_id)
  end

  def apprenant_details
    data = params[:id]
    @apprenant_details = Student.find(data)
  end

  # permet d'afficher les etudiants par classe
  def student_par_classe
    @student_par_class = SalleDeClass.find(current_user.salle_de_class_id)
  end

  # permet d'afficher les etudiants par filiere
  def student_par_filiere
    @student_par_filiere = Filiere.all.where(salle_de_class_id: current_user.salle_de_class_id)
  end

  def classes
    salle_id = current_user.salle_de_class_id
    @classe = TeacherClasse.where(user_id: current_user.id).group(:salle_de_class_id)
  end

  # plannig de validation
  def planning
    @planning = Course.where(user_id: current_user.id).order(created_at: :desc)
  end
end

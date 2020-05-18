class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :update_comment_readed, only: :read_message
  def index
    @current_course = Course.where(user_id: current_user.id).order(created_at: :asc)
    @local_news = LocalNews.all.order(created_at: :desc)
  end

  # teacher messagerie
  def messagerie
    @comments = Comment.where(user_id: current_user.id)
  end

  # epreuves
  def epreuves

  end

  # read message
  def read_message
    @current_comment = Comment.find_by(metakey: params[:key])
    
  end

  def dashboard

  end

  def discuss
    
  end

  def apprenants
    @apprenant = Student.where(salle_de_class_id: current_user.salle_de_class_id).order(:name).page(params[:page]).per(50)  #all.where(salle_de_class_id: current_user.salle_de_class_id).order(:name)
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

  # acceder à une salle de classe
  def go_to_classe
    @classe = SalleDeClass.find_by_token(params[:token])
    @students = Student.where(salle_de_class_id: @classe.id).page(params[:page]).per(10)
  end

  # plannig de validation
  def planning
    @planning = Course.where(user_id: current_user.id).order(created_at: :desc)
  end

  private

  def teacher_presence
    if current_user.role == "teacher"

    end
  end

  # update message or comment reading
  def update_comment_readed
    Comment.find_by(metakey: params[:key]).update(read: true)
  end
end

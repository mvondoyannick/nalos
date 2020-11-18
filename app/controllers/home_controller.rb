class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:discus_chat]
  before_action :update_comment_readed, only: :read_message
  def index
    if current_user.role.name == 'teacher'

      @current_course = Course.where(user_id: current_user.id, deleted: false).order(created_at: :desc)
      @local_news = LocalNews.all.order(created_at: :desc)
      @time_table = TimeTable.all

    elsif current_user.role.name == 'principale'

      redirect_to admin_index_path, notice: 'Redirection forcée vers cette page!'

    elsif current_user.role.name == 'admin'

      redirect_to setup_index_path

    end
  end

  # teacher messagerie
  def messagerie
    @comments = Comment.where(user_id: current_user.id)
  end

  def importation
    TeacherClasse.import(params[:file])
    redirect_to teacher_classes_path, notice: 'Toutes les affectations ont été importées'
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
    if current_user.role.name == "root"

    else
      salle_id = current_user.salle_de_class_id
      @room = SecureRandom.hex(10)
      @etablissement = current_user.structure.name
      @classe = TeacherClasse.where(user_id: current_user.id)#.group(:salle_de_class_id)
    end
  end

  # discus text actionCable
  def discus_chat
    if user_signed_in?
      @url = request.url
      @current_classe = SalleDeClass.find_by_token(params[:token])
      @current_students = Student.where(salle_de_class_id: @current_classe.id).page(params[:page]).per(10)
    else
      render layout: false
    end
  end

  # discus video actionCable + webRTC
  def discus_video

  end

  # programmer un discus
  def discus_schedul

  end

  def apprenants
    #@apprenant = Student.where(structure_id: current_user.structure_id, salle_de_class_id: current_user.salle_de_class_id).order(:name).page(params[:page]).per(50)  #all.where(salle_de_class_id: current_user.salle_de_class_id).order(:name)
    # Recherche des salles de classe de l'enseignant
    @current_classes = TeacherClasse.where(user_id: current_user.id).page(params[:page]).per(10)
      #@current_classes = SalleDeClass.where(structure_id: current_user.structure_id, id: current_classes.salle_de_class_id)

  end

  # details sur un apprenant
  def apprenant_details
    data = params[:id]
    @apprenant_details = Student.find(data)
  end

  #dashboard sur les cours
  def course_dash

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
    @classe = TeacherClasse.where(user_id: current_user.id) #.group(:salle_de_class_id)
  end

  # acceder à une salle de classe
  def go_to_classe
    @classe = SalleDeClass.find_by(token: params[:token])
    if @classe.nil?
      redirect_to salle_classe_path, notice: "Aucun apprenants n'a été trouvé dans cette salle de classe."
    else
      @students = Student.where(salle_de_class_id: @classe.id).page(params[:page]).per(10)
    end
  end

  # send SMS notification to all student/parent classe
  def send_sms_notification_to_classe
    if request.get?
      @current_classe = SalleDeClass.find_by(token: params[:classe], structure_id: current_user.structure_id)
      @current_student_phone = Student.where(salle_de_class_id: @current_classe.id).where("phone != '' ").count
    elsif request.post?
      # make post request
      if params[:all].present?
        # send SMS to all student

      elsif params[:selection].present?
        # send SMS to selected student

      end
    end
  end

  # send sms intent to all class
  # post
  def send_sms_notification_to_classe_intend
    @current_classe = SalleDeClass.find_by_token(params[:classe])

    # get current message
    current_message = params[:message]

    # get teacher informations
    current_teacher = current_user.complete_name

    # inspecting all student with phone number
    Student.where(salle_de_class_id: @current_classe.id).where("phone != ''").each do |student|
      SmsJob.set(wait: 2.minutes).perform_later(phone: student.phone, msg: " .#{current_teacher.upcase}", structure: current_user.structure.name.upcase)
    end
  end

  # plannig de validation
  def planning
    @planning = Course.where(user_id: current_user.id, deleted: false).order(created_at: :desc)
  end

  # managing blog
  def blog_index
    @blogs = Blog.all.page(params[:page]).per(4)
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

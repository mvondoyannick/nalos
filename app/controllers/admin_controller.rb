class AdminController < ApplicationController
  #load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @course = Course.where(course_status_id: CourseStatus.find_by_name('waiting').id, deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)
    @new_account = User.where(structure_id: current_user.structure_id, created_at: Date.today.beginning_of_week..Date.today.end_of_week).page(params[:page]).per(10)
    @course_stats = Course.where(structure_id: current_user.structure_id, deleted: false).group(:chapter).count
    @course_view_stat = Course.group(:counter).count
    @documents = ActiveStorage::Blob.all.limit(10).order(created_at: :desc) #Document.last(2).limit(5)

    # action cable push notifications
    # ActionCable.server.broadcast('notification_channel', "Vous etes actuellement à #{action_name.upcase}.")

    # render new view template
    #render layout: 'application_new'
  end

  # read activestorage content
  def read_active_document
    @document = ActiveStorage::Blob.all.find(params[:document_id])
  end

  def index_new
    @course = Course.where(course_status_id: CourseStatus.find_by_name('waiting').id, deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)
    @new_account = User.where(structure_id: current_user.structure_id, created_at: Date.today.beginning_of_week..Date.today.end_of_week).page(params[:page]).per(10)
    @course_stats = Course.where(structure_id: current_user.structure_id, deleted: false).group(:chapter).count
    @course_view_stat = Course.group(:counter).count
    @documents = ActiveStorage::Blob.all.limit(10).order(created_at: :desc) #Document.last(2).limit(5)

    # action cable push notifications
    ActionCable.server.broadcast('notification_channel', "Vous etes actuellement à #{action_name.upcase}.")
    #render layout: 'application_new'
  end

  def stats_index

    @course_stats = Course.where(structure_id: current_user.structure_id, deleted: false).group(:chapter).count
    @classes = SalleDeClass.all.order(name: :asc)

    #render layout: 'application_new'
  end

  # import excel file
  def import
    Lorem.import(params[:fichier])
    redirect_to root_path, notice: 'Document imported'
  end

  def set_import

  end

  # show all course
  def course_all

    @waiting_course = Course.where(course_status_id: CourseStatus.find_by_name('waiting').id, deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)
    @validated_course = Course.where(course_status_id: CourseStatus.find_by_name('validate').id, deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)
    @course = Course.where(deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)

    if request.original_url.include?('#waiting')
      puts "waiting found"
      @waiting_course = Course.where(course_status_id: CourseStatus.find_by_name('waiting').id, deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)
    elsif params[:validated].present?

    else

      @waiting_course = Course.where(course_status_id: CourseStatus.find_by_name('waiting').id, deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)
      @validated_course = Course.where(course_status_id: CourseStatus.find_by_name('validate').id, deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)
      @course = Course.where(deleted: false, structure_id: current_user.structure_id).order(created_at: :desc).page(params[:page]).per(20)

    end

    #render layout: 'application_new'
  end

  def stream
    opentok = OpenTok::OpenTok.new "47009224", '6f69d24bc9a24359038b2af9323f7a80cb3739ae', :timeout_length => 30
    #token = "T1==cGFydG5lcl9pZD00NzAwOTIyNCZzaWc9NmZjOGE4MzQyMDY1MzQ2ZTBjNmJlZjU0YmNhY2NmNWViYTQ1MWI1YTpzZXNzaW9uX2lkPTJfTVg0ME56QXdPVEl5Tkg1LU1UWXdOalk0T1RRMU5ETTNObjVpVlRadmFITlJaakpPVFZaeU1uRkdRakZQUmtKQmRuVi1RWDQmY3JlYXRlX3RpbWU9MTYwNjY4OTg0MSZub25jZT0wLjc1NjA3MjY0NDQyMDQ4ODImcm9sZT1tb2RlcmF0b3ImZXhwaXJlX3RpbWU9MTYwNzI5NDY0MSZpbml0aWFsX2xheW91dF9jbGFzc19saXN0PQ=="
    session = opentok.create_session #:archive_mode => :always, :media_mode => :routed
    @session_id = session.session_id

    puts @session_id

    @token = opentok.generate_token @session_id, { name: current_user.name }

    # response = opentok.streams.all(session_id)
    # puts "this is the stream #{response}"

  end

  # details des statistique des cours
  def course_all_detail
    c_teacher = params[:t]
    if User.exists?(token: c_teacher)
      @current_user = User.find_by_token(c_teacher)
    else
      # throw an error
      redirect_to course_all_path, notice: 'Enseignant inexistant'
    end
  end

  # student who read teacher course
  def who_read_course
    course_t = params[:course_token]
    if Course.exists?(token: course_t)
      @current_course = Course.find_by_token(course_t)
    else
      redirect_to course_all_path, notice: 'Leçon inexistante!'
    end
  end

  # valider ou suspendre tous les cours
  def course_validate_or_suspend_all
    current_structure = Structure.find(params[:plateform])
    if params[:a] == 'suspend'
      User.where(structure_id: params[:plateform]).each do |user|
        user.courses.each do |course|
          course.update(course_status_id: CourseStatus.find_by_name('waiting').id)
        end
      end
      redirect_to course_all_path, notice: "Tous les leçons de #{current_structure.name} ont été suspendues."
    elsif params[:a] == 'validate'
      User.where(structure_id: params[:plateform]).each do |user|
        user.courses.each do |course|
          course.update(course_status_id: CourseStatus.find_by_name('validate').id)
        end
      end
      redirect_to course_all_path, notice: "Toutes les leçon de #{current_structure.name} ont été validées."
    end
  end

  # course details
  def course_detail
    @course = Course.find(params[:course_id])
    @document = Document.find(@course.document_id).file.find(@course.file_id) #Document.find(@course.document_id).file.find()
  end

  # contact teacher by sms about his course
  def course_detail_contact_teacher
    
  end

  # suspendre un cours
  def course_suspension
    current_course = Course.find(params[:course_id])

    # current_course.course_status_id = 1
    current_waiting_id = CourseStatus.find_by_name('waiting').id
    if current_course.update(course_status_id: current_waiting_id)
      # admin notification
      # Sms.send(phone: current_user.phone1, msg: "Vous venez de suspendre le cours #{current_course.chapter} de Mr/Mme #{current_course.user.complete_name.upcase}.")
      SmsJob.set(wait: 10.seconds).perform_later(phone: current_user.phone1, msg: "Vous venez de suspendre le cours #{current_course.chapter} de Mr/Mme #{current_course.user.complete_name.upcase}.", structure: current_user.structure.name.upcase)

      # send message ton teacher
      # Sms.send(phone: current_course.user.phone1, msg: "Votre leçon #{current_course.chapter} publiée le #{current_course.created_at.strftime("%d %b %Y")} à été suspendu par l'administrateur, Il n'est plus disponilble pour les élèves #{current_course.salle_de_class.name}.")
      SmsJob.set(wait: 10.seconds).perform_later(phone: current_course.user.phone1, msg: "Votre leçon #{current_course.chapter} publiée le #{current_course.created_at.strftime("%d %b %Y")} à été suspendu par l'administrateur, Il n'est plus disponilble pour les élèves #{current_course.salle_de_class.name}.", structure: current_user.structure.name.upcase)


      redirect_to course_all_path, notice: "La leçon #{current_course.chapter} a suspendu et n'est désormais plus ouvert aux apprenants."
    else
      redirect_to course_all_path, notice: "Impossible de suspendre cette leçon : #{current_course.errors.messages}"
    end

  end

  # crm interface
  def crm

  end

  # le calendrier scolaire
  def calendar
    
  end

  # send note to teacher
  def course_send_teacher_note
    if request.get?
      if params[:teacher].present? && params[:course_token].present?
        t = params[:teacher]
        c = params[:course_token]
        if User.exists?(token: t)
          @teacher = User.find_by_token(t).phone1
          @course = Course.find_by_token(c)
        else
          redirect_to course_all_path, notice: 'Impossible de trouver cet enseignant ou cours invalide.'
        end
      else
        redirect_to course_all_path, notice: 'Paramètres manquant'
      end
    elsif request.post?
      SmsJob.set(wait: 2.seconds).perform_now(phone: params[:teacher], message: 'lorem', structure: current_user.structure.name.upcase)
    end
  end

  # course validation
  def course_validation
    course_id = params[:course_id]

    current_course = Course.find(course_id)
    #current_course.course_status_id = 2
    #if current_course.save
    current_validation_id = CourseStatus.find_by_name('validate').id
    if current_course.update(course_status_id: current_validation_id)

      # activeJob notification admin validation
      notification_phone_list = %w(691451189, 696468953)
      notification_phone_list.each do |phone|
        SmsJob.set(wait: 10.seconds).perform_later(phone: phone, msg: "Leçon validée: #{current_course.chapter}\nEnseignant ayant publié: Mr/Mme #{current_course.user.complete_name.upcase}\nSalle de classe: #{current_course.salle_de_class.name}\nAdresse disponibilité cours: #{request.env['SERVER_NAME']}/course/read_course?cours_key=#{current_course.token}&course_id=#{current_course.id}&id=87\nStatut: OK", structure: current_user.structure.name.upcase)
      end

      # send message ton teacher
      # Sms.send(phone: current_course.user.phone1, msg: "Votre leçon #{current_course.chapter} publiée le #{current_course.created_at.strftime("%d %b %Y")} à été validé par l'administrateur. Il est désormais disponible à vos élèves de #{current_course.salle_de_class.name}.")
      SmsJob.set(wait: 10.seconds).perform_later(phone: current_course.user.phone1, msg: "Leçon publiée : #{current_course.chapter}\nDate publication #{current_course.created_at.strftime("%d %b %Y, %Hh:%m")}\nSalle de classe #{current_course.salle_de_class.name} \nEtablissement #{current_user.structure.name.upcase}\nStatut: Cours validée avec succès", structure: current_user.structure.name.upcase)

      # send sms to all student from this class
      Student.where(salle_de_class_id: current_course.salle_de_class_id).each do |student|
        # Sms.send(phone: student.phone, msg: "Bonjour, ")
        SmsJob.set(wait: 10.seconds).perform_later(phone: student.c_pere, msg: "Bonjour #{student.complete_name}, une nouvelle leçon : #{current_course.chapter} vient d'être publiée. Plus d'information sur #{request.original_url}", structure: current_user.structure.name.upcase) if student.c_pere.nil?
        SmsJob.set(wait: 10.seconds).perform_later(phone: student.c_mere, msg: "Bonjour #{student.complete_name}, une nouvelle leçon : #{current_course.chapter} vient d'être publiée. Plus d'information sur #{request.original_url}", structure: current_user.structure.name.upcase) if student.c_mere.nil?
        SmsJob.set(wait: 10.seconds).perform_later(phone: student.c_tuteur, msg: "Bonjour #{student.complete_name}, une nouvelle leçon : #{current_course.chapter} vient d'être publiée. Plus d'information sur #{request.original_url}", structure: current_user.structure.name.upcase) if student.c_tuteur.nil?
        SmsJob.set(wait: 10.seconds).perform_later(phone: student.c_autre, msg: "Bonjour #{student.complete_name}, une nouvelle leçon : #{current_course.chapter} vient d'être publiée. Plus d'information sur #{request.original_url}", structure: current_user.structure.name.upcase) if student.c_autre.nil?
      end

      redirect_to course_all_path, notice: "La leçon #{current_course.chapter} a été validé avec succès \n et est maintenant disponible pour les apprenants."

    else
      # puts current_course.errors.details
      redirect_to course_all_path, notice: "Impossible de valider cette lecon : #{current_course.errors.messages}"

    end
  end

  def document_all
    if current_user.role.name == "root"
      @documents = Document.all
    else
      @documents = Document.where(structure_id: current_user.structure_id)
    end
  end

  # delete course
  def course_delete
    if params[:course_token].present?

      # search course existance
      if Course.exists?(token: params[:course_token], deleted: false)
        c_lecon = Course.find_by_token(params[:course_token])

        # we can delete
        c_lecon.deleted = true

        if c_lecon.save
          redirect_to course_all_path, notice: "La leçon #{c_lecon.chapter.upcase} à été correctement supprimée."
        else
          redirect_to course_all_path, notice: 'Impossible de supprimer la leçon demandée.'
        end

      else

        redirect_to course_all_path, notice: 'Impossible de trouver la leçon demandée.'

      end
    else
      redirect_to course_all_path, notice: 'Certaines informations sont manquantes. Action annulée.'
    end
  end

  # suspend course
  def course_suspend

  end

  def documents
    if current_user.role.name == "root"
      @documents = Document.all
    else
      @documents = Document.where(structure_id: current_user.structure_id)
    end
    #@documents = Document.all
  end

  # Managing teacher, student, admin and administration account
  def accounts
    if current_user.role.name == "root"
      @users = User.all
      @admins = User.all
      @students = Student.all
    else
      @users = User.where(role_id: Role.find_by_name('teacher').id, structure_id: current_user.structure_id)
      @admins = User.where(role_id: Role.find_by_name('admin').id, structure_id: current_user.structure_id)
      @students = Student.where(structure: current_user.structure_id)
    end
  end

  # gestion des enseignants
  def enseignants
    @enseignants = User.where(role_id: 1).page(params[:page]).per(20)
  end

  # liste des teachers
  def teachers
    @enseignants = User.where(role_id: 1, structure_id: current_user.structure_id).page(params[:page]).per(15)
  end

  # import enseignant
  def import_enseignant_intent
    User.import(params[:file])
    redirect_to index_enseignants_path, notice: 'Touts les ensiengnants ont été importées'
  end

  # gestion des salles de classe
  def salle_classes
    @salle_classes = SalleDeClass.all
  end

  # import salle de classe
  def import_salle_classe_intent
    SalleDeClass.import(params[:file])
    redirect_to index_salle_classes_path, notice: 'Import correctement effectué'
  end

  # gestion des matieres
  def matieres
    @matieres = Matiere.all.order(:name).page(params[:page]).per(10)
  end

  # import matiere
  def import_matiere_intent
    Matiere.import(params[:file])
    redirect_to index_matieres_path, notice: 'Toutes les matières ont été importées'
  end

  # import matire from form
  def import_matiere_form
    if request.get?

    elsif request.post?

      current_data = Matiere.new(matiere_params)

      respond_to do |format|
        if current_data.save
          format.html {redirect_to index_matiere_path, notice: 'Nouvelle matiere correctement importéés!'}
        else
          format.html {render import_matiere_form}
        end
      end

    end
  end

  # import student
  def import_student
    @students = Student.all.order(:name).page(params[:page]).per(20)
  end

  def import_student_intent
    # Lorem.import(params[:fichier])
    Student.import(params[:fichier])
    redirect_to root_path, notice: 'Tous les apprenants ont été importés avec succès'
  end

  # importe teacher
  def import_teacher
    @enseignants = User.where(role_id: Role.find_by_name('teacher').id).page(params[:page]).per(20)
  end

  def set_role
    next_role = params[:type]
    current_enseignant = User.find(params[:user_id])
    if next_role == 'admin'
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name('admin').id)
        redirect_to teachers_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé administrateur"
      else
        redirect_to teachers_path, notice: 'Impossible de nommer un nouvel administrateur'
      end
    elsif next_role == 'enseignant'
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name('teacher').id)
        redirect_to teachers_path, notice: "L'enseignant #{current_enseignant.complete_name} a été reclassé en simple enseignant"
      else
        redirect_to teachers_path, notice: 'Impossible de reclasser cet enseignant'
      end
    elsif next_role == 'ap'
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name('admin').id)
        redirect_to teachers_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé Animateur Pédagogique"
      else
        redirect_to teachers_path, notice: 'Impossible de nommer un nouvel Animateur Pédagogique'
      end
    end

  end

  # set role root
  def set_role_root
    next_role = params[:type]
    current_enseignant = User.find(params[:user_id])
    if next_role == 'admin'
      # set user role to admin
      # the max admin is 6 and the less is 1
      admin_number = User.find_by(role_id: Role.find_by_name('admin').id)
      if admin_number.to_i.between?(1..6)
        if current_enseignant.update(role_id: Role.find_by_name('admin').id)
          redirect_to setup_root_structure_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé administrateur"
        else
          redirect_to setup_root_structure_path, notice: 'Impossible de nommer un nouvel administrateur'
        end
      else
        redirect_to setup_root_structure_path, notice: "Impossible d'ajouter comme admin, le nombre maximum d'admin atteint!"
      end
    elsif next_role == 'enseignant'
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name('teacher').id)
        redirect_to setup_root_structure_path, notice: "L'enseignant #{current_enseignant.complete_name} a été reclassé en simple enseignant"
      else
        redirect_to setup_root_structure_path, notice: 'Impossible de reclasser cet enseignant'
      end
    elsif next_role == 'ap'
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name('admin').id)
        redirect_to setup_root_structure_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé Animateur Pédagogique"
      else
        redirect_to setup_root_structure_path, notice: 'Impossible de nommer un nouvel Animateur Pédagogique'
      end
    end

  end

  # set enseignant role from setup_new_root_select
  def enseignant_root_role
    if params[:action].present?
      if params[:user_id].nil?
        redirect_to setup_new_root_select_path, notice: 'Certaines informations semblement etre absencetes.'
      else
        # current_structure = current_user.structure_id
        # begin
        params[:user_id].each do |u|
          User.find(u).update(role_id: Role.find_by_name('admin').id)
        end
        redirect_to setup_new_root_select_path, notice: "Tous les #{params[:user_id].count} enseignant ont été nommés ADMIN avec succès."
      end
    else
      redirect_to setup_new_root_select_path, notice: 'Des données manquent dans votre requête!'
    end
  end

  # intent import teachers
  def import_teacher_intent
    Lorem.import(params[:fichier])
    redirect_to admin_index_path, notice: 'Tous les enseignants ont été importés avec succès'
  end

  private
  def matiere_params
    params.permit(:name, :description)
  end

end

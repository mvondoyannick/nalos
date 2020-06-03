class AdminController < ApplicationController

  before_action :authenticate_user!

  def index
    @course = Course.where(course_status_id: 1).order(created_at: :desc).page(params[:page]).per(10)
    @new_account = User.where(structure_id: current_user.structure_id, created_at: Date.today.beginning_of_week..Date.today.end_of_week).page(params[:page]).per(10)
    @course_stats = Course.group(:matiere_id).count
    @course_view_stat = Course.group(:counter).count
    @user_document_stat = Document.group(:user_id).count
    @documents = ActiveStorage::Blob.all.limit(5).order(created_at: :desc) #Document.last(2).limit(5)
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
    @course = Course.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  # valider ou suspendre tous les cours
  def course_validate_or_suspend_all
    current_structure = Structure.find(params[:plateform])
    if params[:a] == "suspend"
      User.where(structure_id: params[:plateform]).each do |user|
        user.courses.each do |course|
          course.update(course_status_id: 1)
        end
      end
      redirect_to course_all_path, notice: "Tous les leçons de #{current_structure.name} ont été suspendues."
    elsif params[:a] == "validate"
      User.where(structure_id: params[:plateform]).each do |user|
        user.courses.each do |course|
          course.update(course_status_id: 2)
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
    current_waiting_id = CourseStatus.find_by_name("waiting").id
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

  # send note to teacher
  def course_send_teacher_note
    
  end

  # course validation
  def course_validation
    course_id = params[:course_id]

    current_course = Course.find(course_id)
    #current_course.course_status_id = 2
    #if current_course.save
    current_validation_id = CourseStatus.find_by_name("validate").id
    if current_course.update(course_status_id: current_validation_id)

      # activeJob notification
      SmsJob.set(wait: 10.seconds).perform_later(phone: 691451189, msg: "Vous venez de valider la leçon #{current_course.chapter} de Mr/Mme #{current_course.user.complete_name.upcase}. Elle est désormais accessible par tous les élèves de #{current_course.salle_de_class.name} à l'adresse #{request.env['SERVER_NAME']}/course/read_course?cours_key=#{current_course.token}&course_id=#{current_course.id}&id=87.", structure: current_user.structure.name.upcase)

      # send message ton teacher
      # Sms.send(phone: current_course.user.phone1, msg: "Votre leçon #{current_course.chapter} publiée le #{current_course.created_at.strftime("%d %b %Y")} à été validé par l'administrateur. Il est désormais disponible à vos élèves de #{current_course.salle_de_class.name}.")
      # SmsJob.set(wait: 10.seconds).perform_later(phone: current_course.user.phone1, msg: "Votre leçon #{current_course.chapter} publiée le #{current_course.created_at.strftime("%d %b %Y")} à été validé par l'administrateur. Il est désormais disponible à vos élèves de #{current_course.salle_de_class.name}.")

      # send sms to all student from this class
      Student.where(salle_de_class_id: current_course.salle_de_class_id).each do |student|
        # Sms.send(phone: student.phone, msg: "Bonjour, ")
        # SmsJob.set(wait: 10.seconds).perform_later(phone: student.phone, msg: "Bonjour #{student.complete_name}, une nouvelle leçon : #{current_course.chapter} vient d'être publiée. Plus d'information sur #{request.original_url}")
      end

      redirect_to course_all_path, notice: "La leçon #{current_course.chapter} a été validé avec succès."
    else
      # puts current_course.errors.details
      redirect_to course_all_path, notice: "Impossible de valider cette lecon : #{current_course.errors.messages}"
    end
  end

  def document_all
    @documents = Document.all
  end

  # delete course
  def course_delete

  end

  # suspend course
  def course_suspend

  end

  def documents
    @documents = Document.all
  end

  # Managing teacher, student, admin and administration account
  def accounts
    @users = User.where(role_id: 1)
    @admins = User.where(role_id: 2)
    @students = Student.all
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
          format.html {redirect_to index_matiere_path, notice: "Nouvelle matiere correctement importéés!"}
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
    @enseignants = User.where(role_id: 1).page(params[:page]).per(20)
  end

  def set_role
    next_role = params[:type]
    current_enseignant = User.find(params[:user_id])
    if next_role == "admin"
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name("admin").id)
        redirect_to teachers_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé administrateur"
      else
        redirect_to teachers_path, notice: "Impossible de nommer un nouvel administrateur"
      end
    elsif next_role == "enseignant"
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name("teacher").id)
        redirect_to teachers_path, notice: "L'enseignant #{current_enseignant.complete_name} a été reclassé en simple enseignant"
      else
        redirect_to teachers_path, notice: "Impossible de reclasser cet enseignant"
      end
    elsif next_role == "ap"
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name("admin").id)
        redirect_to teachers_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé Animateur Pédagogique"
      else
        redirect_to teachers_path, notice: "Impossible de nommer un nouvel Animateur Pédagogique"
      end
    end

  end

  # set role root
  def set_role_root
    next_role = params[:type]
    current_enseignant = User.find(params[:user_id])
    if next_role == "admin"
      # set user role to admin
      # the max admin is 6 and the less is 1
      admin_number = User.find_by(role_id: Role.find_by_name("admin").id)
      if admin_number.to_i.between?(1..6)
        if current_enseignant.update(role_id: Role.find_by_name("admin").id)
          redirect_to setup_root_structure_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé administrateur"
        else
          redirect_to setup_root_structure_path, notice: "Impossible de nommer un nouvel administrateur"
        end
      else
        redirect_to setup_root_structure_path, notice: "Impossible d'ajouter comme admin, le nombre maximum d'admin atteint!"
      end
    elsif next_role == "enseignant"
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name("teacher").id)
        redirect_to setup_root_structure_path, notice: "L'enseignant #{current_enseignant.complete_name} a été reclassé en simple enseignant"
      else
        redirect_to setup_root_structure_path, notice: "Impossible de reclasser cet enseignant"
      end
    elsif next_role == "ap"
      # set user role to admin
      if current_enseignant.update(role_id: Role.find_by_name("admin").id)
        redirect_to setup_root_structure_path, notice: "L'enseignant #{current_enseignant.complete_name} a été nommé Animateur Pédagogique"
      else
        redirect_to setup_root_structure_path, notice: "Impossible de nommer un nouvel Animateur Pédagogique"
      end
    end

  end

  # set enseignant role from setup_new_root_select
  def enseignant_root_role
    if params[:action].present?
      if params[:user_id].nil?
        redirect_to setup_new_root_select_path, notice: "Certaines informations semblement etre absencetes."
      else
        # current_structure = current_user.structure_id
        # begin
        params[:user_id].each do |u|
          User.find(u).update(role_id: Role.find_by_name("admin").id)
        end
        redirect_to setup_new_root_select_path, notice: "Tous les #{params[:user_id].count} enseignant ont été nommés ADMIN avec succès."
      end
    else
      redirect_to setup_new_root_select_path, notice: "Des données manquent dans votre requête!"
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

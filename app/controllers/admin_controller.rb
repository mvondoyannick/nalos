class AdminController < ApplicationController

  def index
    @course = Course.where(course_status_id: 1)
    @course_stats = Course.group(:matiere_id).count
    @course_view_stat = Course.group(:counter).count
    @user_document_stat = Document.group(:user_id).count
    @documents = ActiveStorage::Blob.all.limit(5) #Document.last(2).limit(5)
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
    @course = Course.all
  end

  # course details
  def course_detail
    @course = Course.find(params[:course_id])
    @document = Document.find(@course.document_id).file.find(@course.file_id) #Document.find(@course.document_id).file.find()
  end

  # course validation
  def course_validation
    course_id = params[:course_id]

    current_course = Course.find(course_id)
    current_course.course_status_id = 2
    if current_course.save
      redirect_to admin_index_path, notice: "Cours N° #{current_course.id} a été validé avec succès."
    else
      # puts current_course.errors.details
      redirect_to admin_index_path, notice: "Impossible de valider ce cours : #{current_course.errors.details}"
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
    @enseignants = User.where(role_id: 1)
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
    @matieres = Matiere.all
  end

  # import matiere
  def import_matiere_intent
    Matiere.import(params[:file])
    redirect_to index_matieres_path, notice: 'Toutes les matières ont été importées'
  end

  # import student
  def import_student
    @students = Student.all.order(:name)
  end

  def import_student_intent
    # Lorem.import(params[:fichier])
    Student.import(params[:fichier])
    redirect_to root_path, notice: 'Tous les apprenants ont été importés avec succès'
  end

  # importe teacher
  def import_teacher

  end

  # intent import teachers
  def import_teacher_intent
    Lorem.import(params[:fichier])
    redirect_to admin_index_path, notice: 'Tous les enseignants ont été importés avec succès'
  end

end

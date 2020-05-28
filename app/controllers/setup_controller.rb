class SetupController < ApplicationController
  before_action :authenticate_user!

  # index of setup plateforme
  def index
  end

  def enseignant_index
    current_role_id = Role.find_by_name('teacher').id
    @current_structure = Structure.find_by_token(params[:token])
    @enseignants = User.where(role_id: current_role_id).where(structure_id: current_user.structure_id).page(params[:page]).per(12)
  end

  # gestion des enseignants
  def manage_enseignant_index
    current_role_id = Role.find_by_name('teacher').id
    @current_structure = Structure.find_by_token(params[:token])
    @enseignants = User.where(role_id: current_role_id).where(structure_id: @current_structure.id).page(params[:page]).per(12)
  end

  # add new enseignant user
  def new_teacher
    token = params[:token]
    current_structure = Structure.find_by_token(token)
    current_role_id = Role.find_by_name('admin')
    teacher = User.new(enseignant_params)
    if teacher.save
      # send sms to teacher and admin
      SmsJob.set(wait: 10.seconds).perform_later(phone: 691451189, msg: "Mr/Mme #{teacher.complete_name} votre compte vient d'etre ajouté, votre login est #{} et votre mot de passe est #{}. Connectez-vous à travers ce lien #{request.original_url}")

      # send sms to all admin team
      # User.where(structure_id: current_structure.id, role_id: current_role_id.id).each do |admin|
      #   SmsJob.set(wait: 5.seconds).perform_later(phone: admin.phone1, msg: "Nouvel utilisateur ajouté #{admin.complete_name} dans la structure #{current_structure.name.upcase} par l'administrateur #{current_user.complete_name}")
      # end

      redirect_to setup_manage_enseignant_index_path(token: token), notice: "Nouvel enseignant ajouté"
    else
      redirect_to :back, notice: "Impossible d'ajouter cet utilisateur : #{teacher.errors.messages}"
    end
  end

  def student_index
    # @students = Student.where()
  end

  def notification_index
  end

  def course_index
    @matieres = Matiere.where(structure_id: current_user.structure_id).page(params[:page]).per(10)
  end

  # supprimer une matiere
  def manage_matiere
    if request.delete?
      # delete record request
      current_matiere = Matiere.find_by_token(params[:token])
      if current_matiere.destroy
        redirect_to setup_course_index_path, notice: "Suppression de la matière #{current_matiere.name} terminée"
      else
        redirect_to setup_course_index_path, notice: "Une erreur est survenue durant le traitement de la requete : #{current_matiere.errors.details}"
      end
    elsif request.post?
      # request recoard request
    elsif request.get?
      # render normal view
    end
  end

  def droits_index

  end

  # gestion des administrateur root users
  def root_structure
    current_role_id = Role.find_by_name("admin").id
    @roots = User.where(structure_id: current_user.structure_id, role_id: current_role_id).page(params[:page]).per(5)

  end

  # list all strcture
  def structure_list
    @structures = Structure.all.page(params[:page]).per(10)
  end

  # details d'une strcture
  def structure_index
    @structure = Structure.find(params[:structure_id])

    current_role_id = Role.find_by_name("admin").id
    @admin = User.find_by(role_id: current_role_id)
  end

  # manage structure
  def manage_structure_index
    token = params[:token]
    @current_structure = Structure.find_by_token(token)
  end

  # delete structure
  def structure_delete

  end

  # adding new structure
  def new_structure
    if request.get?
      # simply render view
    elsif request.post?
      # saving new informations
      structure = Structure.new(structure_params)
      if structure.save
        redirect_to setup_structure_list_path, notice: "#{structure.name} à correctement été ajoutée"
      else
        redirect_to setup_structure_list_path, notice: "Impossible d'ajouter #{structure.name} une erreur est survenue : #{structure.errors.details}"
      end
    elsif request.delete?
      # drop structure
      structure_to_delete_id = params[:structure_id]
      current_structure = Structure.find(structure_to_delete_id)
      if current_structure.delete
        redirect_to setup_structure_list_path, notice: "La structure #{current_structure.name} à été supprimée."
      else
        redirect_to setup_structure_list_path, notice: "Impossible de supprimer #{current_structure.name} une erreur est survenue : #{current_structure.errors.details}"
      end
    end

  end

  # update strucuture
  def update_structure
    puts params[:id]
    structure = Structure.find(params[:id])
    if structure
      if structure.update(structure_update_params)
        redirect_to setup_structure_list_path, notice: "#{structure.name} a été correction mise à jour"
      else
        redirect_to setup_structure_list_path, notice: "Une erreur est survenue durant la mise à jour de #{structure.name} : #{structure.errors.details}"
      end
    else
      redirect_to setup_structure_list_path, notice: "Impossible de trouver la structure cible"
    end
  end

  private

  def structure_params
    params.permit(:name, :slogan, :mobile, :fixe, :pays, :region, :email, :logo)
  end

  # update structure params
  def structure_update_params
    params.permit(:name, :slogan, :mobile, :fixe, :pays, :region, :email, :logo)
  end

  # user enseignant params
  def enseignant_params
    params.permit(:email, :name, :second_name, :matricule, :date_naissance, :lieu_naissance, :cni, :sexe, :phone1, :phone2, :password, :role_id, :structure_id, :cycle_ecole_id, :salle_de_class_id)
  end

end

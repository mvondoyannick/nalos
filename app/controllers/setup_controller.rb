class SetupController < ApplicationController
  before_action :authenticate_user!

  # index of setup plateforme
  def index
  end

  # enseignant update, create form
  def enseignant_index
    current_role_id = Role.find_by_name('teacher').id
    @current_structure = Structure.find(current_user.structure.id)
    @enseignants = User.where(role_id: current_role_id).where(structure_id: current_user.structure_id).page(params[:page]).per(12)
  end

  # gestion des enseignants
  def manage_enseignant_index
    current_role_id = Role.find_by_name('teacher').id
    @current_structure = current_user.structure #Structure.find_by_token(params[:token])
    @enseignants = User.where(role_id: current_role_id, statut: "active").where(structure_id: @current_structure.id).page(params[:page]).per(12)
  end

  # add new enseignant user
  def new_teacher
    if request.post?
      if params[:sms].present?

        current_teacher = User.find_by_token(params[:e_token])
        message = params[:message]

        # send sms
        SmsJob.set(wait: 2.seconds).perform_later(phone: current_teacher.phone1, structure: current_user.structure.name.upcase, msg: message)

        sleep 2

        redirect_to setup_manage_enseignant_index_path(token: params[:token]), notice: "Message SMS envoyé à #{current_teacher.complete_name}"

      else

        # create new record
        token = params[:token]
        current_structure = Structure.find_by_token(token)
        current_role_id = Role.find_by_name('admin')
        teacher = User.new(enseignant_params)
        if teacher.save
          # send sms to teacher and admin
          SmsJob.set(wait: 10.seconds).perform_later(phone: teacher.phone1, structure: current_user.structure.name.upcase, msg: "Mr/Mme #{teacher.complete_name}, bienvenue sur NALSCHOOL. Votre compte #{teacher.role.name} vient d'être ajouté, votre login est #{teacher.matricule} et votre mot de passe est #{params[:password]}. Connectez-vous à travers ce lien #{request.base_url}")

          # send sms to all admin team
          User.where(structure_id: current_structure.id, role_id: current_role_id.id).each do |admin|
            SmsJob.set(wait: 5.seconds).perform_later(phone: admin.phone1, structure: current_user.structure.name.upcase, msg: "Nouvel utilisateur ajouté #{teacher.complete_name} dans la structure #{current_structure.name.upcase} par l'administrateur #{current_user.complete_name}")
          end
          redirect_to setup_manage_enseignant_index_path(token: token), notice: "Nouvel enseignant ajouté"
        else
          redirect_to setup_manage_enseignant_index_path(token: token), notice: "Impossible d'ajouter cet utilisateur : #{teacher.errors.messages}"
        end

      end
    elsif request.patch?
      # modifier un utilisateur
      # current_teacher = User.find_by_token(params[:e_token])
      current_teacher = User.find_by_token(params[:e_token])
      if current_teacher.update(enseignant_update_params)
        redirect_to setup_manage_enseignant_index_path(token: params[:token]), notice: "Nouvel enseignant mise à jour!"
      else
        redirect_to setup_manage_enseignant_index_path(token: params[:token]), notice: "Impossible de mettre à jour cet enseignant : #{current_teacher.errors.messages}"
      end
    elsif request.delete?
      # delete user by changing his status
      if params[:suspend].present?

        current_teacher = User.find_by_token(params[:e_token])
        if current_teacher.update(statut: "inactive")
          redirect_to setup_manage_enseignant_index_path(token: params[:token]), notice: "Utilisateur #{current_teacher.complete_name.upcase} correctement suspendu"
        else
          redirect_to :back, notice: "Impossible de supprimer cet utilisateur : #{current_teacher.errors.messages}"
        end

      else

        current_teacher = User.find_by_token(params[:e_token])
        if current_teacher.update(deleted: true)
          redirect_to setup_manage_enseignant_index_path(token: params[:token]), notice: "Utilisateur #{current_teacher.complete_name.upcase} correctement supprimé"
        else
          redirect_to :back, notice: "Impossible de supprimer cet utilisateur : #{current_teacher.errors.messages}"
        end

      end
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

  # ###############################################################
  #                                                              #
  #                  GESTION DES MATIERES                        #
  #                                                              #
  # ##############################################################
  def matiere_index
    @current_structure = Structure.find_by_token(params[:token])
    @matieres = Matiere.where(structure_id: current_user.structure_id).page(params[:page]).per(10)
  end

  # add new matiere
  def new_matiere
    if request.get?
      # show form view
      @current_structure = Structure.find_by_token(params[:token])
      @matieres = Matiere.where(structure_id: current_user.structure_id).page(params[:page]).per(10)
    elsif request.post?
      # submit new metiere
      if params[:file].present?
        #uppload à file for importation, beginning import
      else
        # normal post
        matiere = Matiere.new(matiere_params)
        if matiere.save
          redirect_to setup_matiere_index_path(token: params[:token]), notice: "Nouvelle matiere #{matiere.name.upcase} ajoutés"
        else
          redirect_to setup_new_matiere_path, notice: "Impossible d'ajoter cette matiere : #{matiere.errors.details}"
        end
      end
    elsif request.delete?
      # delete one or selected matiere
      current_matiere = Matiere.find_by_token(params[:m_token])
      if current_matiere.delete
        redirect_to setup_matiere_index_path(token: params[:token]), notice: "Matière parfaitement supprimé : #{current_matiere.name.upcase}."
      else
        redirect_to setup_new_matiere_path, notice: "Impossible de supprimer cette matière : #{current_matiere.errors.details}"
      end

    elsif request.patch?
      #update existing request by searching matiere
      current_matiere = Matiere.find_by_token(params[:m_token])
      if current_matiere.update(name: params[:name], descriptioin: params[:descriptioin])
        redirect_to setup_matiere_index_path(token: params[:token]), notice: "Matière parfaitement mise à jour : #{current_matiere.name.upcase}."
      else
        redirect_to setup_new_matiere_path, notice: "Impossible de mettre cette matière à jour : #{current_matiere.errors.details}"
      end
    end
    @current_structure = Structure.find_by_token(params[:token])
    @matieres = Matiere.where(structure_id: current_user.structure_id).page(params[:page]).per(10)
  end

  # gestion des administrateur root users
  def root_structure
    current_role_id = Role.find_by_name("admin").id
    @roots = User.where(structure_id: current_user.structure_id, role_id: current_role_id).page(params[:page]).per(5)
  end

  # add selection new root user
  def new_root_select
    @enseignants = User.where(role_id: Role.find_by_name("teacher").id, structure_id: current_user.structure_id, statut: "active")
  end

  # list all strcture
  def structure_list
    if current_user.role.name == "admin"
      @structures = Structure.all.page(params[:page]).per(10)
    else
      @structure = Structure.find(current_user.structure_id)
    end
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
    @current_structure = Structure.find_by(token: token)
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

  # liste apprenants
  def liste_apprenants
    current_structure = current_user.structure.id #Structure.find_by_token(params[:token])
    @students = Student.where(structure: current_structure).page(params[:page]).per(20)
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

  # user update data
  def enseignant_update_params
    params.permit(:name, :second_name, :structure_id, :role_id, :matricule, :cni, :date_naissance, :lieu_naissance)
  end

  # matiere params
  def matiere_params
    params.permit(:name, :structure_id)
  end

end

class SetupController < ApplicationController
  before_action :authenticate_user!

  # index of setup plateforme
  def index
  end

  # ##################################################################################################
  # ############################################ ACADEMIC YEAR #######################################
  #
  # presentation du module année academique
  def academic_year
    @elements = %w(apprenants lecons enseignants matieres classes affectations)
  end

  # Adademic year, show apprenants
  def academic_section
    @cycles = CycleEcole.where(structure_id: current_user.structure_id)
  end

  # lister les salles de classe par cycle d'enseignement
  def academic_salle_de_class
    section_id = params[:section_id]
    @salles = SalleDeClass.where(cycle_ecole_id: section_id, structure_id: current_user.structure_id)
  end

  # liste des etudians par section academique
  def academic_students_section
    section = params[:section_id]
    @students = Student.where(structure_id: current_user.structure_id)
  end
  #
  ################################################## END ############################################

  # enseignant update, create form
  def enseignant_index
    current_role_id = Role.find_by_name('teacher').id
    @current_structure = Structure.find(current_user.structure.id)
    @enseignants = User.where(role_id: current_role_id).where(structure_id: current_user.structure_id).page(params[:page]).per(12)
  end

  # change enseignant/teacher password
  def update_password

    #@teacher = User.find_by(token: params[:t_token], role_id: Role.find_by_name('teacher').id)

    if request.get?

      @teacher = User.find_by(token: params[:t_token], role_id: Role.find_by_name('teacher').id)

      respond_to do |format|
        format.html
      end

    elsif request.post?

      t_token = params[:t_token]
      #t_new_pwd = params[:t_new_pwd]
      default_pwd = params[:default_pwd]
      #t_new_confirm_pwd = params[:t_new_confirm_pwd]

      @teacher = User.find_by(token: params[:t_token], role_id: Role.find_by_name('teacher').id)

      # call module for treatment
      r = CoreTeacher::Modifications.update_pwd(t_token: t_token, default_pwd: default_pwd)

      if r[0]

        respond_to do |format|

          format.html {

            redirect_to setup_manage_enseignant_index_path, notice: r[1]

          }
        end

      else

        respond_to do |format|

          format.html {

            redirect_to setup_manage_enseignant_index_path, notice: r[1]

          }
        end

      end

    end

  end

  # gestion des enseignants
  def manage_enseignant_index
    current_role_id = Role.find_by_name('teacher').id
    @current_structure = current_user.structure #Structure.find_by_token(params[:token])
    @enseignants = User.where(role_id: current_role_id, statut: "active").where(structure_id: @current_structure.id).page(params[:page]).per(12)
  end

  # gestion des enseignants supprimés ou suspendu
  def manage_enseignant_deleted
    current_role_id = Role.find_by_name('teacher').id
    @current_structure = current_user.structure #Structure.find_by_token(params[:token])
    @enseignants = User.where(role_id: current_role_id, statut: "active", deleted: true).where(structure_id: @current_structure.id).page(params[:page]).per(12)
  end

  # restaurer un compte
  def restaure_teacher_account
    t_token = params[:t_token]
    if User.exists?(token: t_token, deleted: true)
      c_teacher = User.find_by_token(t_token)
      if c_teacher.update(deleted: nil )
        redirect_to setup_manage_enseignant_index_path, notice: "#{c_teacher.name.upcase} restauré avec succès"
      else
        redirect_to setup_manage_enseignant_index_path, notice: "Impossible de restaurer cet enseignant"
      end
    else
      redirect_to setup_manage_enseignant_index_path, notice: "Impossible de trouver cet enseignant"
    end
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

  # external API
  def manage_api

  end

  # words processing
  def document_word_server

  end

  # calc processing
  def document_calc_server

  end

  # powerpoint processing
  def document_powerpoint_server

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


  # liste des apprenants incomplet
  def liste_incomplet_apprenants
    current_structure = current_user.structure.id #Structure.find_by_token(params[:token])
    @students = (Student.where(c_pere: nil, structure: current_structure)).or(Student.where(c_mere: nil, structure: current_structure)).or(Student.where(c_tuteur: nil, structure: current_structure)).page(params[:page]).per(20)
  end

  # details d'un apprenant
  def detail_apprenant
    mat = params[:matricule]
    if !mat.present?
      redirect_to setup_liste_apprenants_path, notice: "Cet apprenant semble ne pas exister."
    else
      if Student.exists?(matricule: mat)
        @current_student = Student.find_by(matricule: mat)
      else
        redirect_to setup_liste_apprenants_path, notice: "Apprenant inexistant"
      end
    end

  end

  # modifier le dossier apprenant
  def update_apprenant
    if request.post?

      if params[:m].present?

        if Student.exists?(matricule: params[:m], structure: current_user.structure_id)
          s = Student.find_by_matricule(params[:m])

          if s.update(update_student_params)
            redirect_to detail_apprenant_path(matricule: params[:m]), notice: "Apprenant correctement mis à jour!"
          else
            redirect_to setup_liste_apprenants_path, notice: "Impossible de mettre l'apprenant à jour!"
          end

        end

      else
        redirect_to setup_liste_apprenants_path, notice: "Parametres manquant, impossible de continuer."
      end

    elsif request.get?
      if params[:m].present?
        if Student.exists?(matricule: params[:m])
          @student = Student.find_by_matricule(params[:m])
        else
          redirect_to setup_liste_apprenants_path, notice: "Apprenant inconnu"
        end
      else
        redirect_to setup_liste_apprenants_path, notice: "Parametres manquants"
      end
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

  # user update data
  def enseignant_update_params
    params.permit(:name, :second_name, :structure_id, :role_id, :matricule, :cni, :date_naissance, :lieu_naissance)
  end

  # params student update
  def update_student_params
    params.permit(:name, :second_name, :sexe, :matricule, :salle_de_class_id, :structure, :d_naissance, :l_naissance, :pere, :c_pere, :f_pere, :mere, :c_mere, :f_mere, :tuteur, :c_tuteur, :c_autre)
  end

  # matiere params
  def matiere_params
    params.permit(:name, :structure_id)
  end

end

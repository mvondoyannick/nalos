class SetupController < ApplicationController
  before_action :authenticate_user!

  # index of setup plateforme
  def index
  end

  def enseignant_index
    current_role_id = Role.find_by_name('teacher').id
    @enseignants = User.where(role_id: current_role_id).where(structure_id: current_user.structure_id).page(params[:page]).per(12)
  end

  def student_index
    # @students = Student.where()
  end

  def notification_index
  end

  def course_index
    @matieres = Matiere.where(structure_id: current_user.structure_id).page(params[:page]).per(10)
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
    @admin = User.find_by(role_id: current_role_id, structure_id: @structure.id)
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

  private

  def structure_params
    params.permit(:name, :slogan, :mobile, :fixe, :pays, :region, :email)
  end

end

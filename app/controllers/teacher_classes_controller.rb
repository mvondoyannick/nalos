class TeacherClassesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher_class, only: [:show, :edit, :update, :destroy]

  # GET /teacher_classes
  # GET /teacher_classes.json
  def index
    current_structure = Structure.find_by_token(params[:token])
    @teacher_classes = TeacherClasse.where(structure_id: current_structure.id).group(:user_id).distinct.page(params[:page]).per(100)
  end

  # details of one teacher
  def details
    @current_user = User.find_by_token(params[:token])
    @teacher_classes = TeacherClasse.where(user_id: @current_user.id)
  end

  # delete affectation
  def delete_affectation
    token = params[:token]
    current_affectation = TeacherClasse.find(params[:id])
    if current_affectation.delete
      redirect_to affectation_details_path(token: token), notice: "Affectation correctement supprimée"
    else
      redirect_to affectation_details_path(token: token), notice: "Une erreur est survenue : #{current_affectation.errors.details}"
    end
  end

  # GET /teacher_classes/1
  # GET /teacher_classes/1.json
  def show
  end

  # GET /teacher_classes/new
  def new
    @teacher_class = TeacherClasse.new
  end

  # GET /teacher_classes/1/edit
  def edit
  end

  # POST /teacher_classes
  # POST /teacher_classes.json
  def create
    @teacher_class = TeacherClasse.new(teacher_class_params)

    respond_to do |format|
      if @teacher_class.save
        format.html { redirect_to @teacher_class, notice: 'Teacher classe was successfully created.' }
        format.json { render :show, status: :created, location: @teacher_class }
      else
        format.html { render :new }
        format.json { render json: @teacher_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teacher_classes/1
  # PATCH/PUT /teacher_classes/1.json
  def update
    respond_to do |format|
      if @teacher_class.update(teacher_class_params)
        format.html { redirect_to @teacher_class, notice: 'Teacher classe was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher_class }
      else
        format.html { render :edit }
        format.json { render json: @teacher_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher_classes/1
  # DELETE /teacher_classes/1.json
  def destroy
    @teacher_class.destroy
    respond_to do |format|
      format.html { redirect_to teacher_classes_url, notice: 'Teacher classe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_class
      @teacher_class = TeacherClasse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_class_params
      params.require(:teacher_classe).permit(:user_id, :salle_de_class_id, :matiere_id, :structure_id)
    end
end

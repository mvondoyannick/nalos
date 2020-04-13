class ClasseMatieresController < ApplicationController
  before_action :set_classe_matiere, only: [:show, :edit, :update, :destroy]

  # GET /classe_matieres
  # GET /classe_matieres.json
  def index
    @classe_matieres = ClasseMatiere.all
  end

  # GET /classe_matieres/1
  # GET /classe_matieres/1.json
  def show
  end

  # GET /classe_matieres/new
  def new
    @classe_matiere = ClasseMatiere.new
  end

  # GET /classe_matieres/1/edit
  def edit
  end

  # POST /classe_matieres
  # POST /classe_matieres.json
  def create
    @classe_matiere = ClasseMatiere.new(classe_matiere_params)

    respond_to do |format|
      if @classe_matiere.save
        format.html { redirect_to @classe_matiere, notice: 'Classe matiere was successfully created.' }
        format.json { render :show, status: :created, location: @classe_matiere }
      else
        format.html { render :new }
        format.json { render json: @classe_matiere.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classe_matieres/1
  # PATCH/PUT /classe_matieres/1.json
  def update
    respond_to do |format|
      if @classe_matiere.update(classe_matiere_params)
        format.html { redirect_to @classe_matiere, notice: 'Classe matiere was successfully updated.' }
        format.json { render :show, status: :ok, location: @classe_matiere }
      else
        format.html { render :edit }
        format.json { render json: @classe_matiere.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classe_matieres/1
  # DELETE /classe_matieres/1.json
  def destroy
    @classe_matiere.destroy
    respond_to do |format|
      format.html { redirect_to classe_matieres_url, notice: 'Classe matiere was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classe_matiere
      @classe_matiere = ClasseMatiere.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classe_matiere_params
      params.require(:classe_matiere).permit(:salle_de_class_id, :matiere_id)
    end
end

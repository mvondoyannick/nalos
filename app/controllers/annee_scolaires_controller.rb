class AnneeScolairesController < ApplicationController
  before_action :set_annee_scolaire, only: [:show, :edit, :update, :destroy]

  # GET /annee_scolaires
  # GET /annee_scolaires.json
  def index
    @annee_scolaires = AnneeScolaire.all
  end

  # GET /annee_scolaires/1
  # GET /annee_scolaires/1.json
  def show
  end

  # GET /annee_scolaires/new
  def new
    @annee_scolaire = AnneeScolaire.new
  end

  # GET /annee_scolaires/1/edit
  def edit
  end

  # POST /annee_scolaires
  # POST /annee_scolaires.json
  def create
    @annee_scolaire = AnneeScolaire.new(annee_scolaire_params)

    respond_to do |format|
      if @annee_scolaire.save
        format.html { redirect_to @annee_scolaire, notice: 'Annee scolaire was successfully created.' }
        format.json { render :show, status: :created, location: @annee_scolaire }
      else
        format.html { render :new }
        format.json { render json: @annee_scolaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annee_scolaires/1
  # PATCH/PUT /annee_scolaires/1.json
  def update
    respond_to do |format|
      if @annee_scolaire.update(annee_scolaire_params)
        format.html { redirect_to @annee_scolaire, notice: 'Annee scolaire was successfully updated.' }
        format.json { render :show, status: :ok, location: @annee_scolaire }
      else
        format.html { render :edit }
        format.json { render json: @annee_scolaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annee_scolaires/1
  # DELETE /annee_scolaires/1.json
  def destroy
    @annee_scolaire.destroy
    respond_to do |format|
      format.html { redirect_to annee_scolaires_url, notice: 'Annee scolaire was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annee_scolaire
      @annee_scolaire = AnneeScolaire.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annee_scolaire_params
      params.require(:annee_scolaire).permit(:name, :date_debut, :date_fin)
    end
end

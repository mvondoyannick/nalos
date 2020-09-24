class TrimestresController < ApplicationController
  before_action :set_trimestre, only: [:show, :edit, :update, :destroy]

  # GET /trimestres
  # GET /trimestres.json
  def index
    @trimestres = Trimestre.all
  end

  # GET /trimestres/1
  # GET /trimestres/1.json
  def show
  end

  # GET /trimestres/new
  def new
    @trimestre = Trimestre.new
  end

  # GET /trimestres/1/edit
  def edit
  end

  # POST /trimestres
  # POST /trimestres.json
  def create
    @trimestre = Trimestre.new(trimestre_params)

    respond_to do |format|
      if @trimestre.save
        format.html { redirect_to @trimestre, notice: 'Trimestre was successfully created.' }
        format.json { render :show, status: :created, location: @trimestre }
      else
        format.html { render :new }
        format.json { render json: @trimestre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trimestres/1
  # PATCH/PUT /trimestres/1.json
  def update
    respond_to do |format|
      if @trimestre.update(trimestre_params)
        format.html { redirect_to @trimestre, notice: 'Trimestre was successfully updated.' }
        format.json { render :show, status: :ok, location: @trimestre }
      else
        format.html { render :edit }
        format.json { render json: @trimestre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trimestres/1
  # DELETE /trimestres/1.json
  def destroy
    @trimestre.destroy
    respond_to do |format|
      format.html { redirect_to trimestres_url, notice: 'Trimestre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trimestre
      @trimestre = Trimestre.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trimestre_params
      params.require(:trimestre).permit(:name, :date_debut, :date_fin, :annee_scolaire_id)
    end
end

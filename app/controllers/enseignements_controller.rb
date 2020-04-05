class EnseignementsController < ApplicationController
  before_action :set_enseignement, only: [:show, :edit, :update, :destroy]

  # GET /enseignements
  # GET /enseignements.json
  def index
    @enseignements = Enseignement.all
  end

  # GET /enseignements/1
  # GET /enseignements/1.json
  def show
  end

  # GET /enseignements/new
  def new
    @enseignement = Enseignement.new
  end

  # GET /enseignements/1/edit
  def edit
  end

  # POST /enseignements
  # POST /enseignements.json
  def create
    @enseignement = Enseignement.new(enseignement_params)

    respond_to do |format|
      if @enseignement.save
        format.html { redirect_to @enseignement, notice: 'Enseignement was successfully created.' }
        format.json { render :show, status: :created, location: @enseignement }
      else
        format.html { render :new }
        format.json { render json: @enseignement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enseignements/1
  # PATCH/PUT /enseignements/1.json
  def update
    respond_to do |format|
      if @enseignement.update(enseignement_params)
        format.html { redirect_to @enseignement, notice: 'Enseignement was successfully updated.' }
        format.json { render :show, status: :ok, location: @enseignement }
      else
        format.html { render :edit }
        format.json { render json: @enseignement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enseignements/1
  # DELETE /enseignements/1.json
  def destroy
    @enseignement.destroy
    respond_to do |format|
      format.html { redirect_to enseignements_url, notice: 'Enseignement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_enseignement
    @enseignement = Enseignement.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def enseignement_params
    params.require(:enseignement).permit(:title, :content, :image)
  end
end

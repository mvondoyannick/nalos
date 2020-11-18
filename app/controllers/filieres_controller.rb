class FilieresController < ApplicationController
  before_action :set_filiere, only: [:show, :edit, :update, :destroy]

  # GET /filieres
  # GET /filieres.json
  def index
    @filieres = Filiere.all
  end

  # GET /filieres/1
  # GET /filieres/1.json
  def show
  end

  # GET /filieres/new
  def new
    @filiere = Filiere.new
  end

  # GET /filieres/1/edit
  def edit
  end

  # POST /filieres
  # POST /filieres.json
  def create
    @filiere = Filiere.new(filiere_params)

    respond_to do |format|
      if @filiere.save
        format.html { redirect_to @filiere, notice: 'Filiere was successfully created.' }
        format.json { render :show, status: :created, location: @filiere }
      else
        format.html { render :new }
        format.json { render json: @filiere.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filieres/1
  # PATCH/PUT /filieres/1.json
  def update
    respond_to do |format|
      if @filiere.update(filiere_params)
        format.html { redirect_to @filiere, notice: 'Filiere was successfully updated.' }
        format.json { render :show, status: :ok, location: @filiere }
      else
        format.html { render :edit }
        format.json { render json: @filiere.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filieres/1
  # DELETE /filieres/1.json
  def destroy
    @filiere.destroy
    respond_to do |format|
      format.html { redirect_to filieres_url, notice: 'Filiere was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filiere
      @filiere = Filiere.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filiere_params
      params.require(:filiere).permit(:name, :content, :structure_id)
    end
end

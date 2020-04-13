class CycleEcolesController < ApplicationController
  before_action :set_cycle_ecole, only: [:show, :edit, :update, :destroy]

  # GET /cycle_ecoles
  # GET /cycle_ecoles.json
  def index
    @cycle_ecoles = CycleEcole.all
  end

  # GET /cycle_ecoles/1
  # GET /cycle_ecoles/1.json
  def show
  end

  # GET /cycle_ecoles/new
  def new
    @cycle_ecole = CycleEcole.new
  end

  # GET /cycle_ecoles/1/edit
  def edit
  end

  # POST /cycle_ecoles
  # POST /cycle_ecoles.json
  def create
    @cycle_ecole = CycleEcole.new(cycle_ecole_params)

    respond_to do |format|
      if @cycle_ecole.save
        format.html { redirect_to @cycle_ecole, notice: 'Cycle ecole was successfully created.' }
        format.json { render :show, status: :created, location: @cycle_ecole }
      else
        format.html { render :new }
        format.json { render json: @cycle_ecole.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cycle_ecoles/1
  # PATCH/PUT /cycle_ecoles/1.json
  def update
    respond_to do |format|
      if @cycle_ecole.update(cycle_ecole_params)
        format.html { redirect_to @cycle_ecole, notice: 'Cycle ecole was successfully updated.' }
        format.json { render :show, status: :ok, location: @cycle_ecole }
      else
        format.html { render :edit }
        format.json { render json: @cycle_ecole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cycle_ecoles/1
  # DELETE /cycle_ecoles/1.json
  def destroy
    @cycle_ecole.destroy
    respond_to do |format|
      format.html { redirect_to cycle_ecoles_url, notice: 'Cycle ecole was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cycle_ecole
      @cycle_ecole = CycleEcole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cycle_ecole_params
      params.require(:cycle_ecole).permit(:name, :code, :detail, :structure_id)
    end
end

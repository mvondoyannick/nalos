class StructureTypesController < ApplicationController
  before_action :set_structure_type, only: [:show, :edit, :update, :destroy]

  # GET /structure_types
  # GET /structure_types.json
  def index
    @structure_types = StructureType.all
  end

  # GET /structure_types/1
  # GET /structure_types/1.json
  def show
  end

  # GET /structure_types/new
  def new
    @structure_type = StructureType.new
  end

  # GET /structure_types/1/edit
  def edit
  end

  # POST /structure_types
  # POST /structure_types.json
  def create
    @structure_type = StructureType.new(structure_type_params)

    respond_to do |format|
      if @structure_type.save
        format.html { redirect_to @structure_type, notice: 'Structure type was successfully created.' }
        format.json { render :show, status: :created, location: @structure_type }
      else
        format.html { render :new }
        format.json { render json: @structure_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /structure_types/1
  # PATCH/PUT /structure_types/1.json
  def update
    respond_to do |format|
      if @structure_type.update(structure_type_params)
        format.html { redirect_to @structure_type, notice: 'Structure type was successfully updated.' }
        format.json { render :show, status: :ok, location: @structure_type }
      else
        format.html { render :edit }
        format.json { render json: @structure_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /structure_types/1
  # DELETE /structure_types/1.json
  def destroy
    @structure_type.destroy
    respond_to do |format|
      format.html { redirect_to structure_types_url, notice: 'Structure type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_structure_type
      @structure_type = StructureType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def structure_type_params
      params.require(:structure_type).permit(:name, :description)
    end
end

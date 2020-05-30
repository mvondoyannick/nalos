class SalleDeClassesController < ApplicationController
  before_action :set_salle_de_class, only: [:show, :edit, :update, :destroy]

  # GET /salle_de_classes
  # GET /salle_de_classes.json
  def index
    @salle_de_classes = SalleDeClass.all.page(params[:page]).per(10)
  end

  # GET /salle_de_classes/1
  # GET /salle_de_classes/1.json
  def show
  end

  # GET /salle_de_classes/new
  def new
    @salle_de_class = SalleDeClass.new
  end

  # GET /salle_de_classes/1/edit
  def edit
  end

  # POST /salle_de_classes
  # POST /salle_de_classes.json
  def create
    @salle_de_class = SalleDeClass.new(salle_de_class_params)

    respond_to do |format|
      if @salle_de_class.save
        format.html { redirect_to @salle_de_class, notice: 'Salle de class was successfully created.' }
        format.json { render :show, status: :created, location: @salle_de_class }
      else
        format.html { render :new }
        format.json { render json: @salle_de_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salle_de_classes/1
  # PATCH/PUT /salle_de_classes/1.json
  def update
    respond_to do |format|
      if @salle_de_class.update(salle_de_class_params)
        format.html { redirect_to @salle_de_class, notice: 'Salle de class was successfully updated.' }
        format.json { render :show, status: :ok, location: @salle_de_class }
      else
        format.html { render :edit }
        format.json { render json: @salle_de_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salle_de_classes/1
  # DELETE /salle_de_classes/1.json
  def destroy
    @salle_de_class.destroy
    respond_to do |format|
      format.html { redirect_to salle_de_classes_url, notice: 'Salle de class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salle_de_class
      @salle_de_class = SalleDeClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def salle_de_class_params
      params.require(:salle_de_class).permit(:name, :effectif, :cycle_ecole_id)
    end
end

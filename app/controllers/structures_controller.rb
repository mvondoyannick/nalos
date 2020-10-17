class StructuresController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_structure, only: [:show, :edit, :update, :destroy]

  # GET /structures
  # GET /structures.json
  def index
    @structures = Structure.all
  end

  # GET /structures/1
  # GET /structures/1.json
  def show
  end

  # GET /structures/new
  def new
    @structure = Structure.new
  end

  # GET /structures/1/edit
  def edit
  end

  # POST /structures
  # POST /structures.json
  def create
    @structure = Structure.new(structure_params)

    respond_to do |format|
      if @structure.save

        # redirection
        if request.referer.include?('new')

          # send notifications
          CreateUserJob.set(wait: 10.seconds).perform_later(name: @structure.name, email: @structure.email, structure_id: @structure.id)
          # make redirections
          format.html { redirect_to root_path, notice: 'Structure was successfully created.' }
          # format.json { render :show, status: :created, location: @structure }
        else
          format.html { redirect_to @structure, notice: 'Structure was successfully created.' }
          format.json { render :show, status: :created, location: @structure }
        end
      else
        format.html { render :new }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /structures/1
  # PATCH/PUT /structures/1.json
  def update
    respond_to do |format|
      if @structure.update(structure_params)
        format.html { redirect_to request.referer, notice: 'Structure was successfully updated.' }
        format.json { render :show, status: :ok, location: @structure }
      else
        format.html { render :edit }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /structures/1
  # DELETE /structures/1.json
  def destroy
    @structure.destroy
    respond_to do |format|
      format.html { redirect_to structures_url, notice: 'Structure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # gestion de la structure index
  def manage_structure
    # Afficher le menu globale pour la gestion de la structure
    token = params[:token]
    if Structure.exists?(token: token)
      @structure = Structure.find_by_token(token)
    else
      redirect_to setup_index_path, notice: "Impossible de trouver votre établissement"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_structure
      @structure = Structure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def structure_params
      # params.fetch(:structure, {:name, })
      params.require(:structure).permit(:name, :email, :slogan, :mobile, :fixe, :region, :pays, :logo, :rccm, :creation)
    end

  # only accept user params
  def user_params
    params.permit(:user_name, :user_email, :user_main_phone, :user_second_phone, :user_date_delivrance, :user_cni, :cycle_name)
  end
end

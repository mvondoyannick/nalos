class EpreuvesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_epreufe, only: [:show, :edit, :update, :destroy]

  # GET /epreuves
  # GET /epreuves.json
  def index
    @epreuves = Epreuve.where(user_id: current_user.id)
  end

  # GET /epreuves/1
  # GET /epreuves/1.json
  def show
    @data = current_user.e_responses
  end

  # verifier une épreuve
  def verif_epreuve
    if request.get?
      resp = params[:e_id]
      @response = EResponse.find(resp)
    elsif request.post?
      rep = params[:responde_id]
      current_response = EResponse.find(rep)
      if current_response.update(statut: true)
        # send SMS to sutudent
        redirect_to epreuves_path, notice: "Epreuve validé, correction en cours de transmission via email et SMS"
      else
        redirect_to epreuves_path, notice: "Impossible de valide cette epreuve"
      end
    end

  end

  # GET /epreuves/new
  def new
    @epreufe = Epreuve.new
  end

  # GET /epreuves/1/edit
  def edit
  end

  # POST /epreuves
  # POST /epreuves.json
  def create
    @epreufe = Epreuve.new(epreufe_params)

    respond_to do |format|
      if @epreufe.save
        format.html { redirect_to @epreufe, notice: 'Epreuve was successfully created.' }
        format.json { render :show, status: :created, location: @epreufe }
      else
        puts @epreufe.errors.details
        format.html { render :new }
        format.json { render json: @epreufe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epreuves/1
  # PATCH/PUT /epreuves/1.json
  def update
    respond_to do |format|
      if @epreufe.update(epreufe_params)
        format.html { redirect_to @epreufe, notice: 'Epreuve was successfully updated.' }
        format.json { render :show, status: :ok, location: @epreufe }
      else
        format.html { render :edit }
        format.json { render json: @epreufe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epreuves/1
  # DELETE /epreuves/1.json
  def destroy
    @epreufe.destroy
    respond_to do |format|
      format.html { redirect_to epreuves_url, notice: 'Epreuve was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_epreufe
    @epreufe = Epreuve.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def epreufe_params
    params.require(:epreuve).permit(:title, :salle_de_class_id, :matiere_id, :user_id, :file, :response)
  end
end

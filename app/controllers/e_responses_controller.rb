class EResponsesController < ApplicationController
  before_action :set_e_response, only: [:show, :edit, :update, :destroy]

  # GET /e_responses
  # GET /e_responses.json
  def index
    @e_responses = EResponse.all
  end

  # GET /e_responses/1
  # GET /e_responses/1.json
  def show
  end

  # GET /e_responses/new
  def new
    @e_response = EResponse.new
  end

  # GET /e_responses/1/edit
  def edit
  end

  # POST /e_responses
  # POST /e_responses.json
  def create
    @e_response = EResponse.new(e_response_params)

    respond_to do |format|
      if @e_response.save
        format.html { redirect_to @e_response, notice: 'E response was successfully created.' }
        format.json { render :show, status: :created, location: @e_response }
      else
        format.html { render :new }
        format.json { render json: @e_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /e_responses/1
  # PATCH/PUT /e_responses/1.json
  def update
    respond_to do |format|
      if @e_response.update(e_response_params)
        format.html { redirect_to @e_response, notice: 'E response was successfully updated.' }
        format.json { render :show, status: :ok, location: @e_response }
      else
        format.html { render :edit }
        format.json { render json: @e_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /e_responses/1
  # DELETE /e_responses/1.json
  def destroy
    @e_response.destroy
    respond_to do |format|
      format.html { redirect_to e_responses_url, notice: 'E response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_e_response
      @e_response = EResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def e_response_params
      params.require(:e_response).permit(:epreuve_id, :student_id, :user_id, :salle_de_class_id, :fichier, :description)
    end
end

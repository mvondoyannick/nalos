class TrsController < ApplicationController
  before_action :set_tr, only: [:show, :edit, :update, :destroy]

  # GET /trs
  # GET /trs.json
  def index
    @trs = Tr.all
  end

  # GET /trs/1
  # GET /trs/1.json
  def show
  end

  # GET /trs/new
  def new
    @tr = Tr.new
  end

  # GET /trs/1/edit
  def edit
  end

  # POST /trs
  # POST /trs.json
  def create
    @tr = Tr.new(tr_params)

    respond_to do |format|
      if @tr.save
        format.html { redirect_to @tr, notice: 'Tr was successfully created.' }
        format.json { render :show, status: :created, location: @tr }
      else
        format.html { render :new }
        format.json { render json: @tr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trs/1
  # PATCH/PUT /trs/1.json
  def update
    respond_to do |format|
      if @tr.update(tr_params)
        format.html { redirect_to @tr, notice: 'Tr was successfully updated.' }
        format.json { render :show, status: :ok, location: @tr }
      else
        format.html { render :edit }
        format.json { render json: @tr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trs/1
  # DELETE /trs/1.json
  def destroy
    @tr.destroy
    respond_to do |format|
      format.html { redirect_to trs_url, notice: 'Tr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tr
      @tr = Tr.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tr_params
      params.require(:tr).permit(:name, :debut, :fin, :yr_id)
    end
end

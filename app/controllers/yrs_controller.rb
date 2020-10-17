class YrsController < ApplicationController
  before_action :set_yr, only: [:show, :edit, :update, :destroy]

  # GET /yrs
  # GET /yrs.json
  def index
    @yrs = Yr.where(structure_id: current_user.structure_id)
  end

  # GET /yrs/1
  # GET /yrs/1.json
  def show
  end

  # GET /yrs/new
  def new
    @yr = Yr.new
  end

  # GET /yrs/1/edit
  def edit
  end

  # POST /yrs
  # POST /yrs.json
  def create
    @yr = Yr.new(yr_params)
    @yr.structure_id = current_user.structure_id

    respond_to do |format|
      if @yr.save
        format.html { redirect_to @yr, notice: 'Yr was successfully created.' }
        format.json { render :show, status: :created, location: @yr }
      else
        puts @yr.errors.details
        format.html { render :new }
        format.json { render json: @yr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /yrs/1
  # PATCH/PUT /yrs/1.json
  def update
    respond_to do |format|
      if @yr.update(yr_params)
        format.html { redirect_to @yr, notice: 'Yr was successfully updated.' }
        format.json { render :show, status: :ok, location: @yr }
      else
        format.html { render :edit }
        format.json { render json: @yr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yrs/1
  # DELETE /yrs/1.json
  def destroy
    @yr.destroy
    respond_to do |format|
      format.html { redirect_to yrs_url, notice: 'Yr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yr
      @yr = Yr.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def yr_params
      params.require(:yr).permit(:name, :end, :debut)
    end
end

class TimeTablesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_table, only: [:show, :edit, :update, :destroy]

  # GET /time_tables
  # GET /time_tables.json
  def index
    @time_tables = TimeTable.all
  end

  # GET /time_tables/1
  # GET /time_tables/1.json
  def show
  end

  # GET /time_tables/new
  def new
    @time_table = TimeTable.new
  end

  # GET /time_tables/1/edit
  def edit
  end

  # POST /time_tables
  # POST /time_tables.json
  def create
    @time_table = TimeTable.new(time_table_params)

    respond_to do |format|
      if @time_table.save

        # link classes
        #@current_classe =

        # send information to this teacher
        #SmsJob.set(wait: 2.seconds).perform_later(phone: "", msg: "", structure: "NALOS")
        # send notification to student

        format.html { redirect_to @time_table, notice: 'Time table was successfully created.' }
        format.json { render :show, status: :created, location: @time_table }
      else
        format.html { render :new }
        format.json { render json: @time_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_tables/1
  # PATCH/PUT /time_tables/1.json
  def update
    respond_to do |format|
      if @time_table.update(time_table_params)
        format.html { redirect_to @time_table, notice: 'Time table was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_table }
      else
        format.html { render :edit }
        format.json { render json: @time_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_tables/1
  # DELETE /time_tables/1.json
  def destroy
    @time_table.destroy
    respond_to do |format|
      format.html { redirect_to time_tables_url, notice: 'Time table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_table
      @time_table = TimeTable.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def time_table_params
      params.require(:time_table).permit(:periode_debut, :periode_fin, :filiere_id, :salle_de_class_id, :structure_id, :file)
    end
end

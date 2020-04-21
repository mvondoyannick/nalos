class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.where(user_id: current_user.id)
  end

  def detail_content
    data = params[:id]
    @document = Document.where(id: data, user_id: current_user.id)
  end

  def join_to_course
    current_document = params[:current_file_id]
    @current_file = Document.find(params[:document_id]).file.find(params[:current_file_id])
  end

  def preview_course
    @current_file = Document.find(params[:document_id]).file.find(params[:file_id])
  end

  def create_course_from_document
    @course = Course.new(course_params)

    current_course = ManageCourse.save_course(course_params)

    if current_course[0]
      puts "enregistré"
      redirect_to courses_path
    else
      puts current_course[1]
    end

  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.fetch(:document, {}).permit(:user_id, file: [])
    end

  def course_params
    params.permit(:user_id, :document_id, :file_id, :matiere_id, :chapter, :salle_de_class_id, :categorie, :tag, :extrait, :course_status_id)
  end
end

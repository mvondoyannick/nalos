class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all.where(user_id: current_user.id, deleted: false).order(created_at: :desc).page(params[:page]).per(18)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # search tags
  def list_course_tags
    current_course = Course.find_by_token(params[:token])

    # begin searching course on all plateforme and only for this class
    c_tags = []
    current_tag = Course.all.each do |tag|
      tag.tag.split(',').each do |r|
        c_tags << r.delete(' ')
      end
    end

    puts c_tags
    last_course = []
    c_tags.each do |info|
      last_course << Course.find_by_tag(info)
    end

    last_course.each do |lorem|
      puts lorem
    end

  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    # @course.destroy
    @course.update(deleted: true)
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:chapter, :extrait, :file, :user_id, :matiere_id, :tag, :categorie)
    end
end

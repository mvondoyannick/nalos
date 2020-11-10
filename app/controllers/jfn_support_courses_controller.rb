class JfnSupportCoursesController < ApplicationController
  before_action :set_jfn_support_course, only: [:show, :edit, :update, :destroy]
  layout 'application_new'

  # GET /jfn_support_courses
  # GET /jfn_support_courses.json
  def index
    @jfn_support_courses = JfnSupportCourse.all
  end

  # GET /jfn_support_courses/1
  # GET /jfn_support_courses/1.json
  def show
  end

  # GET /jfn_support_courses/new
  def new
    @jfn_support_course = JfnSupportCourse.new
  end

  # GET /jfn_support_courses/1/edit
  def edit
  end

  # POST /jfn_support_courses
  # POST /jfn_support_courses.json
  def create
    @jfn_support_course = JfnSupportCourse.new(jfn_support_course_params)

    respond_to do |format|
      if @jfn_support_course.save
        format.html { redirect_to @jfn_support_course, notice: 'Jfn support course was successfully created.' }
        format.json { render :show, status: :created, location: @jfn_support_course }
      else
        format.html { render :new }
        format.json { render json: @jfn_support_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jfn_support_courses/1
  # PATCH/PUT /jfn_support_courses/1.json
  def update
    respond_to do |format|
      if @jfn_support_course.update(jfn_support_course_params)
        format.html { redirect_to @jfn_support_course, notice: 'Jfn support course was successfully updated.' }
        format.json { render :show, status: :ok, location: @jfn_support_course }
      else
        format.html { render :edit }
        format.json { render json: @jfn_support_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jfn_support_courses/1
  # DELETE /jfn_support_courses/1.json
  def destroy
    @jfn_support_course.destroy
    respond_to do |format|
      format.html { redirect_to jfn_support_courses_url, notice: 'Jfn support course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jfn_support_course
      @jfn_support_course = JfnSupportCourse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def jfn_support_course_params
      params.permit(:title, :description, :user_id, :document, :content_description)
    end
end

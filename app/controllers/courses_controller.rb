class CoursesController < ApplicationController
  before_action :require_login
  before_action :set_course, only: [ :edit, :update, :destroy ]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to courses_path, notice: "Course created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  if @course.update(course_params)
    redirect_to courses_path, notice: "Course updated successfully."
  else
    render :edit, status: :unprocessable_entity
  end
end

  def destroy
  @course.destroy
  redirect_to courses_path,
              notice: "Course deleted successfully."
end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(
      :course_code,
      :course_name,
      :duration,
      :fees,
      :total_seats
    )
  end
end

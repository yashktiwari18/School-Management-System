class TeachersController < ApplicationController
  before_action :require_login
  before_action :set_teacher, only: [ :edit, :update, :destroy ]
  before_action :load_courses, only: [ :new, :create, :edit, :update ]

  def index
    @teachers = Teacher.includes(:course)
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to teachers_path, notice: "Teacher created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to teachers_path, notice: "Teacher updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher.destroy
    redirect_to teachers_path, notice: "Teacher deleted successfully."
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def load_courses
  @courses = Course.order(:course_name)
end

  def teacher_params
    params.require(:teacher).permit(
      :teacher_name,
      :email,
      :phone,
      :education,
      :course_id
    )
  end
end

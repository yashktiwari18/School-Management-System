class StudentsController < ApplicationController
  before_action :require_login
  before_action :set_student, only: [:edit, :update, :destroy]
  before_action :load_courses, only: [:new, :create, :edit, :update]

  def index
    @students = Student.includes(:course)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to students_path, notice: "Student created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to students_path, notice: "Student updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: "Student deleted successfully."
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def load_courses
    @courses = Course.order(:course_name)
  end

  def student_params
    params.require(:student).permit(
      :student_name,
      :email,
      :phone,
      :gender,
      :admission_date,
      :address,
      :course_id
    )
  end
end
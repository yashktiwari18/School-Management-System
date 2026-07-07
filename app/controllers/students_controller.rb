class StudentsController < ApplicationController
  before_action :require_login
  before_action :set_student, only: [ :show, :edit, :update, :destroy ]
  before_action :load_courses, only: [ :new, :create, :edit, :update ]

  def index
    @students = Student.includes(:course)
  end

  def show
    @student = Student.find(params[:id])
    @fee = @student.fees.order(created_at: :desc).first
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save

      log_activity(
        action: "Created",
        module_name: "Student",
        description: "Added student #{@student.student_name}"
      )

      redirect_to students_path,
                  notice: "Student created successfully."

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      log_activity(
    action: "Updated",
    module_name: "Student",
    description: "Updated student #{@student.student_name}"
  )
      redirect_to students_path, notice: "Student updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    log_activity(
  action: "Deleted",
  module_name: "Student",
  description: "Deleted student #{@student.student_name}"
)
    @student.destroy
    redirect_to students_path, notice: "Student deleted successfully."
  end

  def latest_fee
    fees.order(created_at: :desc).first
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

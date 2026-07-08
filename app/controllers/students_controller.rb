class StudentsController < ApplicationController
  before_action :require_login
  before_action :set_student, only: [ :show, :edit, :update, :destroy ]
  before_action :load_courses, only: [ :new, :create, :edit, :update ]

  def index
    @students = Student.includes(:course)
  end

  def fees
    @student = Student.find(params[:id])

    @fee = @student.fee

    unless @fee
      @fee = @student.build_fee(
        total_fee: 0,
        paid_fee: 0,
        due_fee: 0,
        status: "Pending"
    )
    end
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

      Fee.create!(
      student: @student,
      total_fee: @student.course.fees,
      paid_fee: 0,
      due_fee: @student.course.fees,
      status: "Pending"
      )

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

  def collect_fee
  @student = Student.find(params[:id])

  @fee = @student.fee

  unless @fee
    @fee = @student.create_fee(
      total_fee: 0,
      paid_fee: 0,
      due_fee: 0,
      status: "Pending"
    )
  end

  amount = params[:payment_amount].to_f

  if amount > @fee.due_fee
  redirect_to fees_student_path(@student),
              alert: "Payment amount cannot exceed pending fee."
  return
  end

  if amount <= 0
    redirect_to fees_student_path(@student),
                alert: "Please enter a valid payment amount."
    return
  end

  @fee.paid_fee += amount
  @fee.due_fee = @fee.total_fee - @fee.paid_fee
  @fee.payment_date = params[:payment_date]

  if @fee.due_fee <= 0
    @fee.due_fee = 0
    @fee.status = "Paid"
  elsif @fee.paid_fee > 0
    @fee.status = "Partial"
  else
    @fee.status = "Pending"
  end

  if @fee.save
    redirect_to fees_student_path(@student),
                notice: "Fee collected successfully."
  else
    redirect_to fees_student_path(@student),
                alert: "Unable to collect fee."
  end
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

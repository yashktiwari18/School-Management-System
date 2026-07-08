class FeesController < ApplicationController
  before_action :require_login
  before_action :set_fee, only: [ :edit, :update, :destroy ]
  before_action :load_students, only: [ :new, :create, :edit, :update ]

  def index
    @fees = Fee.includes(:student)
    @total_collection = Fee.sum(:total_fee)
    @total_paid = Fee.sum(:paid_fee)
    @total_pending = Fee.sum(:due_fee)
    @overdue_count = Fee.where(status: "Overdue").count

    # Search by student name
    if params[:search].present?
      @fees = @fees.joins(:student)
                  .where("students.student_name ILIKE ?", "%#{params[:search]}%")
    end

    # Filter by status
    if params[:status].present? && params[:status] != "All Status"
      @fees = @fees.where(status: params[:status])
    end
  end

  def new
    @fee = Fee.new
  end

  def create
    @fee = Fee.new(fee_params)

    calculate_due_fee

    if @fee.save
      redirect_to fees_path, notice: "Fee record created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    calculate_due_fee

    if @fee.update(fee_params)
      redirect_to fees_path, notice: "Fee record updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fee.destroy
    redirect_to fees_path, notice: "Fee record deleted successfully."
  end

  private

  def set_fee
    @fee = Fee.find(params[:id])
  end

  def load_students
    @students = Student.order(:student_name)
  end

  def fee_params
    params.require(:fee).permit(
      :student_id,
      :total_fee,
      :paid_fee,
      :payment_date,
      :status
    )
  end

  def calculate_due_fee
    total = fee_params[:total_fee].to_f
    paid  = fee_params[:paid_fee].to_f

    @fee.due_fee = total - paid
  end
end

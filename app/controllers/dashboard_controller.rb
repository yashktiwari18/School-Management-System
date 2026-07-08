class DashboardController < ApplicationController
  before_action :require_login

  def index
  @students_count = Student.count
  @teachers_count = Teacher.count
  @courses_count  = Course.count

  @fees_collected = Fee.sum(:paid_fee)

  @recent_students = Student
                      .includes(:course)
                      .order(created_at: :desc)
                      .limit(5)

  @recent_fees = Fee.includes(:student)
                  .where("paid_fee > 0")
                  .order(payment_date: :desc)
                  .limit(5)
  end
end

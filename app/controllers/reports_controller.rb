class ReportsController < ApplicationController
  def index
  # Student Reports
  @admissions_this_month = Student.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).count

  @admissions_this_year = Student.where(created_at: Time.current.beginning_of_year..Time.current.end_of_year).count

  @latest_student = Student.order(created_at: :desc).first

  @popular_course = Course.joins(:students)
                          .group("courses.id")
                          .order("COUNT(students.id) DESC")
                          .first


# Teacher Reports

@teachers_count = Teacher.count

@latest_teacher = Teacher.order(created_at: :desc).first

@highest_qualification = Teacher.group(:education)
                                .order(Arel.sql("COUNT(*) DESC"))
                                .count
                                .first

@course_allocation = Course
                      .left_joins(:teachers)
                      .group("courses.course_name")
                      .count

# ===========================
# Course Reports
# ===========================

@courses_count = Course.count

@most_popular_course = Course
                          .left_joins(:students)
                          .group("courses.id")
                          .order(Arel.sql("COUNT(students.id) DESC"))
                          .first

@largest_course = Course
                    .left_joins(:students)
                    .group("courses.id")
                    .order(Arel.sql("COUNT(students.id) DESC"))
                    .first

@student_per_course = if @courses_count.positive?
                        (Student.count.to_f / @courses_count).round(1)
else
                        0
end




# ===========================
# Finance Reports
# ===========================

@total_collection = Fee.sum(:paid_fee)

@pending_fees = Fee.sum(:due_fee)

@monthly_revenue = Fee.where(
  payment_date: Date.current.beginning_of_month..Date.current.end_of_month
).sum(:paid_fee)

@overdue_payments = Fee.where(status: "Overdue").count
end
end

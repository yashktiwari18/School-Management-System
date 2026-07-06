class AttendancesController < ApplicationController
  before_action :load_workspace_data, only: [:index, :workspace]
  before_action :require_login

  def index
    
  end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)

    if @attendance.save
      redirect_to attendances_path,
                  notice: "Attendance marked successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def workspace
    @tab = params[:tab]

    partial =
  case @tab
  when "overview"
    "overview"
  when "student"
    "student_attendance"
  when "teacher"
    "teacher_attendance"
  when "reports"
    "reports"
  when "leave"
    "leave_management"
  when "settings"
    "settings"
  else
    "overview"
  end

   render partial: "workspace",
       locals: {
         partial: partial,
         tab: @tab
       }
  end

  private

  def load_workspace_data
  @attendances = Attendance.includes(:student)
                           .order(attendance_date: :desc)

  @courses  = Course.includes(:students).order(:course_name)
  @students = Student.includes(:course).order(:student_name)
  @teachers = Teacher.includes(:course).order(:teacher_name)

  today = Date.current

  today_records = Attendance.where(attendance_date: today)

  @total_students = Student.count
  @students_present = today_records.where(status: "Present").count
  @students_absent  = today_records.where(status: "Absent").count
  @students_late    = today_records.where(status: "Late").count

  @attendance_rate =
    if @total_students.zero?
      0
    else
      ((@students_present.to_f / @total_students) * 100).round(2)
    end

  @total_teachers = Teacher.count

  # temporary until teacher attendance module
  @teachers_present = 0
end

  def attendance_params
    params.require(:attendance)
          .permit(
            :student_id,
            :attendance_date,
            :status,
            :remarks
          )
  end
end

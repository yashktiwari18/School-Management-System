class AttendancesController < ApplicationController
  before_action :require_login

  def index
    @attendances = Attendance.includes(:student)
                             .order(attendance_date: :desc)


    @courses = Course.includes(:students)
    @teachers = Teacher.includes(:course)
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

  private

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

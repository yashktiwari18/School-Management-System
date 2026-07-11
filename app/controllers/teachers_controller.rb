class TeachersController < ApplicationController
  before_action :require_login
  before_action :set_teacher, only: [ :show, :edit, :update, :destroy ]
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

  def show
  today = Date.current

  @yesterday = (today - 1.day).strftime("%A")
  @today = today.strftime("%A")
  @tomorrow = (today + 1.day).strftime("%A")

  @yesterday_schedule = @teacher.timetables
                                .where(day: @yesterday)
                                .order(:period)

  @today_schedule = @teacher.timetables
                            .where(day: @today)
                            .order(:period)

  @tomorrow_schedule = @teacher.timetables
                               .where(day: @tomorrow)
                               .order(:period)

  @assigned_classes = @teacher.timetables
                            .includes(:course)
                            .group_by(&:course)
  @assigned_subjects = @teacher.timetables.group_by(&:subject)
  current_time = Time.current

  @total_classes = @today_schedule.count

  @completed_classes = @today_schedule.count do |schedule|
    current_time > schedule.end_time
  end

  @ongoing_classes = @today_schedule.count do |schedule|
    current_time >= schedule.start_time &&
    current_time <= schedule.end_time
  end

  @upcoming_classes = @today_schedule.count do |schedule|
    current_time < schedule.start_time
  end
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
      :gender,
      :education,
      :course_id
    )
  end
end

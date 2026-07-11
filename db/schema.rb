# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_10_104832) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.string "action"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "module_name"
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_activity_logs_on_admin_id"
  end

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.string "username"
  end

  create_table "attendances", force: :cascade do |t|
    t.date "attendance_date", null: false
    t.datetime "created_at", null: false
    t.text "remarks"
    t.string "status", null: false
    t.bigint "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_code"
    t.string "course_name"
    t.datetime "created_at", null: false
    t.string "duration"
    t.decimal "fees"
    t.integer "total_seats"
    t.datetime "updated_at", null: false
  end

  create_table "fees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "due_fee"
    t.decimal "paid_fee"
    t.date "payment_date"
    t.string "payment_mode"
    t.string "status"
    t.bigint "student_id", null: false
    t.decimal "total_fee"
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_fees_on_student_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_read"
    t.text "message"
    t.string "notification_type"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.text "address"
    t.date "admission_date"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.string "gender"
    t.string "phone"
    t.string "student_name"
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_students_on_course_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.string "education"
    t.string "email"
    t.string "gender"
    t.string "phone"
    t.string "teacher_name"
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_teachers_on_course_id"
  end

  create_table "timetables", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.string "day"
    t.time "end_time"
    t.integer "period"
    t.string "room"
    t.time "start_time"
    t.string "subject"
    t.bigint "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_timetables_on_course_id"
    t.index ["teacher_id"], name: "index_timetables_on_teacher_id"
  end

  add_foreign_key "activity_logs", "admins"
  add_foreign_key "attendances", "students"
  add_foreign_key "fees", "students"
  add_foreign_key "students", "courses"
  add_foreign_key "teachers", "courses"
  add_foreign_key "timetables", "courses"
  add_foreign_key "timetables", "teachers"
end

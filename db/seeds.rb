Admin.find_or_create_by!(username: "admin") do |admin|
  admin.name = "Administrator"
  admin.password = "admin123"
  admin.password_confirmation = "admin123"
end

puts "Admin created successfully!"


puts "Cleaning existing data..."

Fee.destroy_all
Student.destroy_all
Teacher.destroy_all
Course.destroy_all

puts "Creating courses..."

courses = []
courses << Course.create!(
  course_name: "Bachelor of Computer Applications",
  course_code: "BCA",
  duration: "3 Years",
  fees: 50000
)

courses << Course.create!(
  course_name: "Bachelor of Business Administration",
  course_code: "BBA",
  duration: "3 Years",
  fees: 60000
)

courses << Course.create!(
  course_name: "B.Tech Information Technology",
  course_code: "BIT",
  duration: "4 Years",
  fees: 85000
)

courses << Course.create!(
  course_name: "Bachelor of Commerce",
  course_code: "BCOM",
  duration: "3 Years",
  fees: 45000
)

courses << Course.create!(
  course_name: "Master of Business Administration",
  course_code: "MBA",
  duration: "2 Years",
  fees: 120000
)

puts "Creating teachers..."

10.times do |i|
  Teacher.create!(

    teacher_name: "Teacher #{i + 1}",
    email: "teacher#{i + 1}@school.com",
    phone: "9876543#{format('%03d', i)}",
    education: [ "M.Tech", "MBA", "MCA", "PhD", "M.Sc" ].sample,
    gender: i.even? ? "Male" : "Female",
    course: courses.sample

  )
end

puts "Creating students and fees..."

30.times do |i|
  course = courses.sample

  student = Student.create!(

    student_name: "Student #{i + 1}",
    email: "student#{i + 1}@school.com",
    phone: "912345#{format('%04d', i)}",
    gender: i.even? ? "Male" : "Female",
    admission_date: Date.today - rand(250).days,
    address: "Greater Noida",
    course: course

  )

  paid = rand(course.fees * 0.2..course.fees * 0.8).to_i

  status =
    if paid == course.fees
      "Paid"
    elsif paid.zero?
      "Pending"
    else
      "Partial"
    end

  Fee.create!(

    student: student,

    total_fee: course.fees,

    paid_fee: paid,

    due_fee: course.fees - paid,

    payment_date: Date.today - rand(30).days,

    payment_mode: [ "Cash", "UPI", "Card" ].sample,

    status: status

  )
end

puts "---------------------------------------"
puts "Database Seeded Successfully!"
puts "Courses : #{Course.count}"
puts "Teachers: #{Teacher.count}"
puts "Students: #{Student.count}"
puts "Fees     : #{Fee.count}"
puts "---------------------------------------"


teacher = Teacher.first

course = Course.find_by(course_name: "Bachelor of Computer Applications")

Timetable.create!(
  teacher: teacher,
  course: course,
  day: "Thursday",
  period: 1,
  start_time: "09:00",
  end_time: "10:00",
  subject: "Database Management",
  room: "A-201"
)

Timetable.create!(
  teacher: teacher,
  course: course,
  day: "Thursday",
  period: 2,
  start_time: "10:00",
  end_time: "11:00",
  subject: "Java Programming",
  room: "A-203"
)

Timetable.create!(
  teacher: teacher,
  course: course,
  day: "Thursday",
  period: 4,
  start_time: "01:00",
  end_time: "02:00",
  subject: "Web Development",
  room: "C-102"
)

Course.find_by(course_code: "BCA")&.update(total_seats: 60)

Course.find_by(course_code: "BBA")&.update(total_seats: 80)

Course.find_by(course_code: "BIT")&.update(total_seats: 120)

Course.find_by(course_code: "BCOM")&.update(total_seats: 60)

Course.find_by(course_code: "MBA")&.update(total_seats: 40)

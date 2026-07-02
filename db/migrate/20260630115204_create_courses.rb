class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_code
      t.string :duration
      t.decimal :fees

      t.timestamps
    end
  end
end

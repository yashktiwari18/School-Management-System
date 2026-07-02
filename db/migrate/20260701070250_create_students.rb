class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.string :student_name
      t.string :email
      t.string :phone
      t.string :gender
      t.date :admission_date
      t.text :address
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end

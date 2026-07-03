class CreateAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :attendances do |t|
      t.references :student, null: false, foreign_key: true
      t.date :attendance_date, null: false
      t.string :status, null: false
      t.text :remarks

      t.timestamps
    end
  end
end

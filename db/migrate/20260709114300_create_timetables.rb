class CreateTimetables < ActiveRecord::Migration[8.1]
  def change
    create_table :timetables do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :day
      t.integer :period
      t.time :start_time
      t.time :end_time
      t.string :subject
      t.string :room

      t.timestamps
    end
  end
end

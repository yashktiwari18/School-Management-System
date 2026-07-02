class CreateTeachers < ActiveRecord::Migration[8.1]
  def change
    create_table :teachers do |t|
      t.string :teacher_name
      t.string :email
      t.string :phone
      t.string :education
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end

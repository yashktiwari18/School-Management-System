class AddGenderToTeachers < ActiveRecord::Migration[8.1]
  def change
    add_column :teachers, :gender, :string
  end
end

class AddTotalSeatsToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :total_seats, :integer
  end
end

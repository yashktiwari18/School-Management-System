class Attendance < ApplicationRecord
  belongs_to :student

  validates :attendance_date, presence: true

  validates :status,
            presence: true,
            inclusion: {
              in: %w[
                Present
                Absent
                Leave
                Holiday
              ]
            }
end

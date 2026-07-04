class Course < ApplicationRecord
  has_many :teachers, dependent: :destroy
  has_many :students, dependent: :destroy

  validates :course_code,
            presence: true,
            uniqueness: true

  validates :course_name,
            presence: true

  validates :duration,
            presence: true

  validates :fees,
            numericality: {
              greater_than: 0
            }
end

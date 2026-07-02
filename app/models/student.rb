class Student < ApplicationRecord
  belongs_to :course
  has_many :fees, dependent: :destroy

  validates :student_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :gender, presence: true
  validates :admission_date, presence: true
  validates :address, presence: true
  validates :course, presence: true
end
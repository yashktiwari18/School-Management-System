class Teacher < ApplicationRecord
  belongs_to :course

  validates :teacher_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :education, presence: true
  validates :course, presence: true
end
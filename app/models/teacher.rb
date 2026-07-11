class Teacher < ApplicationRecord
  belongs_to :course
  has_many :timetables, dependent: :destroy
  has_many :attendances

  validates :teacher_name,
            presence: true,
            length: { minimum: 3 }

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :phone,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A\d{10}\z/,
              message: "must be exactly 10 digits"
            }
  validates :gender,
            inclusion: {
              in: %w[Male Female Other]
            }
  validates :education, presence: true
  validates :course, presence: true
end

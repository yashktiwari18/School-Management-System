class Fee < ApplicationRecord
  belongs_to :student

  validates :total_fee, presence: true
  validates :paid_fee, presence: true
  validates :due_fee, presence: true
  validates :status, presence: true
end
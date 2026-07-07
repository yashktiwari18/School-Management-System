class ActivityLog < ApplicationRecord
  belongs_to :admin

  validates :action, presence: true
  validates :module_name, presence: true
  validates :description, presence: true
end

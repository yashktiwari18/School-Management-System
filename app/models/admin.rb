class Admin < ApplicationRecord
  has_secure_password

  validates :name,
            presence: true

  validates :username,
            presence: true,
            uniqueness: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "is invalid"
            }

  validates :phone,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A\d{10}\z/,
              message: "must be exactly 10 digits"
            }

  validates :password,
            length: { minimum: 8 },
            if: -> { password.present? }
end

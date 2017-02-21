class Borrower < ApplicationRecord
  has_secure_password
  has_many :histories

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :email, :password_digest, :amount, :reason, :explanation, presence: true
  validates :name, :amount, length: {in: 2..20}
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

end

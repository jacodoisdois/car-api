class Customer < ApplicationRecord
  validates :phone, length: { minimum: 11, maximum: 11 }
  validates :name, presence: true, length: { maximum: 60 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
end

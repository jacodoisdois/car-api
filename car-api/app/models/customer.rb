class Customer < ApplicationRecord
  has_one :phone, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, presence: true, length: { maximum: 150 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :birth_date, presence: true
  validates :social_security_number, length: { minimum: 10, maximum: 11 }

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :phone
  accepts_nested_attributes_for :cars, allow_destroy: true
end

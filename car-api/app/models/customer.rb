class Customer < ApplicationRecord
  has_one :phone, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 150 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :date_birth, presence: true

end

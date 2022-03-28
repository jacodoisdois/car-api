class Service < ApplicationRecord
  has_many :order_services, dependent: :destroy
  has_many :order, through: :order_services

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 10_000_000 }
  validates :description, presence: true, length: { minimum: 10, maximum: 400 }
end

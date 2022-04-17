class Product < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :order, through: :order_products

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 400 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 10_000_000 }
  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 1, less_than: 10_000_000, only_integer: true }
end

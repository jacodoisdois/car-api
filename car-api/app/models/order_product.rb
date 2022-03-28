class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product, inverse_of: :order_products

  validates :total, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1001 }
end

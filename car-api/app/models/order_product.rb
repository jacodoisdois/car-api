class OrderProduct < ApplicationRecord
  before_validation :set_product_total!

  belongs_to :product
  belongs_to :order

  validates :total, presence: true, numericality: { greater_or_equal_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 1001 }

  validate :total_is_the_product_between_price_and_quantity
end

def total_is_the_product_between_price_and_quantity
  errors.add(:total, 'Total product cost need to be price * quantity') if total != product.price * quantity
end

def set_product_total!
  self.total = product.price * quantity
end

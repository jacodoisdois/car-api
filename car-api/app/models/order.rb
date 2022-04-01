class Order < ApplicationRecord
  after_validation :set_order_total!, on: %i[create update]

  belongs_to :customer

  has_many :services, through: :order_services
  has_many :order_services, dependent: :destroy

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
end

def set_order_total!
  self.total = self.order_products.map(&:total).sum
end

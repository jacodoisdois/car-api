class Order < ApplicationRecord
  belongs_to :customer

  has_many :services, through: :order_services
  has_many :order_services, dependent: :destroy

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
end

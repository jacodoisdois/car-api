class Order < ApplicationRecord
  after_validation :set_order_total!, on: %i[create update]

  belongs_to :customer

  has_many :services, through: :order_services
  has_many :order_services, dependent: :destroy

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  def set_order_total!
    self.total = self.order_products.map(&:total).sum
  end

  def build_order_products_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      order_product = order_products.build(
        product_id: product_id_and_quantity[:product_id],
        quantity: product_id_and_quantity[:quantity]
      )
      yield order_product if block_given?
    end
  end
end

class Order < ApplicationRecord
  after_validation :set_order_total!, on: %i[create update]

  belongs_to :customer

  has_many :services, through: :order_services
  has_many :order_services, dependent: :destroy

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  validates_associated :order_products

  def set_order_total!
    self.total = self.order_products.map(&:total).sum
  end

  def build_order_products_with_product_ids_and_quantities(product_ids_and_quantities, _order)
    product_ids_and_quantities.each do |product_id_and_quantity|
      Product.find(product_id_and_quantity[:product_id])

      order_product = order_products.build(
        product_id: product_id_and_quantity[:product_id],
        quantity: product_id_and_quantity[:quantity]
      )
      yield order_product if block_given?
    end
  end

  scope :filter_by_product_name, lambda { |keyword|
    joins(:products).where("title like '%#{keyword}%' ")
  }

  scope :recent, lambda { |order|
    order == 'true' ? order(created_at: :desc) : order(created_at: :asc)
  }

  scope :price_equal_or_below, lambda { |_total|
    where('total <= ? ', price)
  }

  scope :price_equal_or_above, lambda { |_total|
    where('total >= ? ', price)
  }

  def self.search(params = {})
    orders = if params[:orders_ids].present?
               Order.find(params[:orders_ids])
             else
               Order.all
             end

    orders = orders.filter_by_product_name(params[:keyword]) if params[:keyword]
    orders = orders.recent(params[:recent]) if params[:recent].present?
    orders = orders.total_equal_or_above(params[:min_total]) if params[:min_total]
    orders = orders.total_equal_or_below(params[:max_total]) if params[:max_total]

    orders
  end
end

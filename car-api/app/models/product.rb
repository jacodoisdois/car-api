class Product < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :order, through: :order_products

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 400 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 10_000_000 }
  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 1, less_than: 10_000_000, only_integer: true }

  scope :filter_by_name, lambda { |keyword|
                           where("(lower(description) LIKE '%#{keyword.downcase}%' or lower(title) LIKE '%#{keyword.downcase}%') ")
                         }

  scope :recent, lambda { |order|
    order == 'true' ? order(created_at: :desc) : order(created_at: :asc)
  }

  scope :price_equal_or_below, lambda { |price|
    where('price <= ? ', price)
  }

  scope :price_equal_or_above, lambda { |price|
    where('price >= ? ', price)
  }

  def self.search(params = {})
    products = if params[:product_ids].present?
                 Product.find(params[:product_ids])
               else
                 Product.all
               end

    products = products.filter_by_name(params[:keyword]) if params[:keyword]
    products = products.recent(params[:recent]) if params[:recent].present?
    products = products.price_equal_or_above(params[:min_price]) if params[:min_price]
    products = products.price_equal_or_below(params[:max_price]) if params[:max_price]

    products
  end
end

class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[show create update destroy index]
  before_action :set_order, only: %i[update destroy show]
  before_action :order_customer, only: %i[create]

  include Paginable

  def create
    order = Order.new customer: order_customer
    order.build_order_products_with_product_ids_and_quantities(order_params[:product_ids_and_quantities], order)

    if order.save
      render json: OrderSerializer.new(order).serializable_hash, status: :created
    else
      render json: { errors: order.errors }, status: :forbidden
    end
  end

  def index
    @orders = Order.includes(:customer)
                   .page(current_page)
                   .per(per_page)
                   .search(params)

    options = get_links_serializer_options('api_v1_orders_path', @orders)

    render json: OrderSerializer.new(@orders, options).serializable_hash
  end

  def show
    render json: OrderSerializer.new(@order).serializable_hash, include: [:order_products]
  end

  def destroy
    @order.destroy
    head :no_content
  end

  def update
    if @order.update(order_params)
      render json: OrderSerializer.new(@order).serializable_hash, status: :ok
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_customer
    Customer.find(params[:customer_id])
  end

  def order_params
    params.require(:order).permit(:id, :customer_id, product_ids_and_quantities: %i[product_id quantity])
  end
end

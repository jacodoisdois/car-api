class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[show create update destroy]
  before_action :set_order, only: %i[update destroy show]
  before_action :order_customer, only: %i[create]

  def create
    order = Order.create! customer: order_customer
    order.build_order_products_with_product_ids_and_quantities(order_params[:product_ids_and_quantities])

    if order.save
      render json: order, status: :created
    else
      render json: { errors: order.errors }, status: :forbidden
    end
  end

  def index; end

  def show; end

  def destroy; end

  def update; end

  private

  def order_customer
    Customer.find(params[:customer_id])
  end

  def order_params
    params.require(:order).permit(:id, :customer_id, product_ids_and_quantities: %i[product_id quantity])
  end
end

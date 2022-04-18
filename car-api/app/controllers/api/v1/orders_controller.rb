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

  def index
    render json: Order.all, include: [:order_products]
  end

  def show
    render json: Order.find(params[:id]), include: [:order_products]
  end

  def destroy
    @order.destroy
    head :no_content
  end

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
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

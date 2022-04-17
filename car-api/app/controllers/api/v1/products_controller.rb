class Api::V1::ProductsController < ApplicationController
  before_action :check_login, only: %i[show create update destroy]
  before_action :set_product, only: %i[update destroy show]

  def index
    render json: Product.all
  end

  def show
    render json: Product.find(params[:id])
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(products_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def products_params
    params.require(:product).permit(:id, :title, :description, :price, :quantity)
  end
end

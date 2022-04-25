class Api::V1::ProductsController < ApplicationController
  before_action :check_login, only: %i[show create update destroy index]
  before_action :set_product, only: %i[update destroy show]
  include Paginable

  def index
    @products = Product.page(current_page)
                       .per(per_page)
                       .search(params)

    options = get_links_serializer_options('api_v1_products_path', @products)

    render json: ProductSerializer.new(@products, options).serializable_hash
  end

  def show
    render json: ProductSerializer.new(@product).serializable_hash, status: :ok
  end

  def create
    @product = Product.new(products_params)

    if @product.save
      render json: ProductSerializer.new(@product).serializable_hash, status: :created
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(products_params)
      render json: ProductSerializer.new(@product).serializable_hash, status: :ok
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

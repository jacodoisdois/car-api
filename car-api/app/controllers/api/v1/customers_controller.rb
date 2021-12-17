class Api::V1::CustomersController < ApplicationController
  before_action :set_user, only: %i[show create update destroy]
  before_action :check_user, only: %i[show create update destroy]
  before_action :set_customer, only: %i[update destroy]

  def show
    render json: Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      render json: @customer, status: :ok
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    head 204
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :email, :phone)
  end

  def set_user
    @user = User.find(JsonWebToken.decode(request.headers['Authorization'])['user_id'])
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def check_user
    puts request.headers
    head :forbidden unless @user.id == current_user&.id
  end
end

class Api::V1::CustomersController < ApplicationController
  before_action :set_user, only: %i[show create]
  before_action :check_user, only: %i[show create]

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

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :phone)
  end

  def set_user
    @user = User.find(JsonWebToken.decode(request.headers['Authorization'])["user_id"])
  end

  def check_user
    puts request.headers
    head :forbidden unless @user.id == current_user&.id
  end
end

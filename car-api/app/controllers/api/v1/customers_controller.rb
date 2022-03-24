class Api::V1::CustomersController < ApplicationController
  before_action :set_user, only: %i[show create update destroy]
  before_action :check_login, only: %i[show create update destroy]
  before_action :set_customer, only: %i[update destroy]

  def show
    render json: Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, include: [:addresses], status: :created
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
    head :no_content
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :email, :social_security_number, :birth_date,
                                     :last_purchase_date,
                                     addresses_attributes: %i[
                                       id address district city state zip_code number _destroy
                                     ],
                                     phone_attributes: %i[id country_code local_code number],
                                     cars_attributes: %i[id model brand year color _destroy])
  end

  def set_user
    @user = User.find(JsonWebToken.decode(request.headers['Authorization'])['user_id'])
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end

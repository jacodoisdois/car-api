require 'test_helper'

class Api::V1::CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @user = users(:one)
  end

  test 'should show customer' do
    get api_v1_customer_url(@customer),
        headers: {
          Authorization: JsonWebToken.encode(user_id: @user.id)
        },
        as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @customer.id, json_response['id']
  end

  test 'should create customer' do
    assert_difference('Customer.count') do
      post api_v1_customers_url,
           params: {
             customer: {
               name: 'Customer name',
               email: 'customeremail@gmail.com',
               phone: 11233455667
             }
           },
           headers: {
             Authorization: JsonWebToken.encode(user_id: @user.id)
           },
           as: :json
      assert_response :created
    end
  end

  test 'should not create user with taken email' do
    assert_no_difference('Customer.count') do
      post api_v1_customers_url,
           params: {
             customer: {
               name: 'Customer name',
               email: @customer.email,
               phone: 21122334455
             }
           },
           headers: {
             Authorization: JsonWebToken.encode(user_id: @user.id)
           },
           as: :json
    end
  end
end

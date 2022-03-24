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
               name: 'Pedro do teste',
               email: 'pedrodoteste@gmail.com',
               social_security_number: 1_234_567_891,
               birth_date: '02-02-1993',
               addresses_attributes: [{
                 address: 'Rua Carvalho Mendes',
                 number: 130,
                 district: 'Vila Rio',
                 city: 'Merengué',
                 state: 'Minas Gerais',
                 main_address: true,
                 zip_code: '07054010'
               }],
               phone_attributes: {
                 country_code: '55',
                 local_code: '11',
                 number: 934_580_345
               },
               cars_attributes: [
                 {
                   model: 'Gol',
                   brand: 'Volkswagen',
                   color: 'Green',
                   year: 2004
                 }
               ]
             }
           },
           headers: {
             Authorization: JsonWebToken.encode(user_id: @user.id)
           },
           as: :json
      assert_response :created
    end
  end

  test 'should not create customer with taken email' do
    assert_no_difference('Customer.count') do
      post api_v1_customers_url,
           params: {
             customer: {
               name: 'João do teste',
               email: @customer.email,
               birth_date: '02-02-1992'
             }
           },
           headers: {
             Authorization: JsonWebToken.encode(user_id: @user.id)
           },
           as: :json
    end
  end

  test 'should update customer' do
    patch api_v1_customer_url(@customer),
          params: { customer: { email: @customer.email } },
          headers: {
            Authorization: JsonWebToken.encode(user_id: @user.id)
          },
          as: :json
    assert_response :success
  end

  test 'should not update customer when invalid params are sent' do
    patch api_v1_customer_url(@customer),
          params: {
            customer: {
              email: 'bad_email',
              name: 123
            }
          },
          headers: {
            Authorization: JsonWebToken.encode(user_id: @user.id)
          },
          as: :json

    assert_response :unprocessable_entity
  end

  test 'should destroy a customer' do
    assert_difference('Customer.count', -1) do
      delete api_v1_customer_url(@customer),
             headers: {
               Authorization: JsonWebToken.encode(user_id: @user.id)
             },
             as: :json
    end
    assert_response :no_content
  end
end

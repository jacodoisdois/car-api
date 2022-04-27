require 'test_helper'

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @user = users(:one)
    @customer = customers(:one)

    @auth = JsonWebToken.encode(user_id: @user.id)

    @order_params = {
      customer_id: @customer.id,
      order: {
        product_ids_and_quantities: [
          { product_id: products(:one).id, quantity: 10 },
          { product_id: products(:two).id, quantity: 10 }
        ]
      }
    }
  end

  test 'should create order' do
    assert_difference('Order.count', 1) do
      assert_difference('OrderProduct.count', 2) do
        post api_v1_orders_url,
             params: @order_params,
             headers: { Authorization: @auth },
             as: :json
      end
      assert_response :success
    end
  end

  test 'should unauthorized for unlogged' do
    get api_v1_orders_url, as: :json
    assert_response :unauthorized
  end

  test 'should index orders' do
    get api_v1_orders_url,
        headers: { Authorization: @auth },
        as: :json

    orders = Order.all

    json_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal orders.count, json_response[:data].count
    assert_json_response_is_paginated json_response
    assert_response :success
  end

  test 'should show order' do
    get api_v1_orders_url(id: @order.id),
        headers: { Authorization: @auth },
        as: :json

    assert_response :success
  end

  test 'should destroy order' do
    assert_difference('Order.count', -1) do
      delete api_v1_order_url(id: @order.id),
             headers: { Authorization: @auth },
             as: :json
    end
    assert_response :no_content
  end

  test 'should update order' do
    patch api_v1_order_url(@order),
          params: {
            order: {
              order_products: []
            }
          },
          headers: { Authorization: @auth },
          as: :json

    assert_response :success
  end
end

require 'test_helper'

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @product = products(:one)
  end

  test 'should get index' do
    get api_v1_products_url,
        headers: {
          Authorization: JsonWebToken.encode(user_id: @user.id)
        },
        as: :json
    assert_response :success
  end

  test 'should get show' do
    get api_v1_product_url(@product),
        headers: {
          Authorization: JsonWebToken.encode(user_id: @user.id)
        },
        as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @product.id, json_response['id']
  end

  test 'should get create' do
    assert_difference('Product.count') do
      post api_v1_products_url,
           params: {
             product: {
               title: 'Sweet bread',
               description: '0.2oz Sweet bread',
               price: 10.02,
               quantity: 10
             }
           },
           headers: {
             Authorization: JsonWebToken.encode(user_id: @user.id)
           },
           as: :json
    end

    assert_response :created
  end

  test 'should get update' do
    patch api_v1_product_url(@product),
          params: {
            product: { title: 'Garlic bread' }
          },
          headers: {
            Authorization: JsonWebToken.encode(user_id: @user.id)
          },
          as: :json

    assert_response :success
  end

  test 'should get destroy' do
    assert_difference('Product.count', -1) do
      delete api_v1_product_url(@product),
             headers: {
               Authorization: JsonWebToken.encode(user_id: @user.id)
             },
             as: :json
    end
    assert_response :no_content
  end
end

require 'test_helper'

class Api::V1::TokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get JWT token' do
    post api_v1_tokens_url,
         params: {
           user: {
             input: @user.email,
             password: 'Password@1233'
           }
         },
         as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['token']
  end

  test 'should not get JWT token' do
    post api_v1_tokens_url,
         params: {
           user: {
             input: @user.email,
             password: 'pass'
           }
         },
         as: :json
    assert_response :unauthorized
  end
end

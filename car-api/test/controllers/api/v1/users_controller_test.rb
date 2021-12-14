# frozen_string_literal: true

require 'test_helper'
class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should show user' do
    get api_v1_user_url(@user), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @user.email, json_response['email']
  end

  test 'should create user' do
    assert_difference('User.count') do
      post api_v1_users_url,
           params: {
             user: {
               name: 'Jonas brother',
               email: 'testertest123@gmail.com',
               password: '123456as'
             }
           },
           as: :json
      assert_response :created
    end
  end

  test 'should update user' do
    patch api_v1_user_url(@user), params: { user: { email: @user.email, password: '123456' } }, as: :json
    assert_response :success
  end

  test 'should not update user when invalid params are sent' do
    patch api_v1_user_url(@user), params: { user: { email: 'bad_email', password: '123456', name: 'Brincan ciclan' } },
                                  as: :json
    assert_response :unprocessable_entity
  end

  test 'should not create user with taken email' do
    assert_no_difference('User.count') do
      post api_v1_users_url,
           params: {
             user: {
               email: @user.email,
               password: '12312333',
               name: 'User name'
             }
           },
           as: :json
    end
    assert_response :unprocessable_entity
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :no_content
  end
end
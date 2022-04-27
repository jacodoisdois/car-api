# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'user with a valid email shoud be valid' do
    user = User.new(email: 'tester@gmail.com', password_digest: 'tesT@12345', name: 'Jonas jhon')
    assert user.valid?
  end

  test 'user with a invalid email should be invalid' do
    user = User.new(email: 'teste.com', password_digest: 'test', name: 'Jonas jhon')
    assert_not user.valid?
  end
end

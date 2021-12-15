require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'customer with a valid email shoud be valid' do
    customer = Customer.new(email: 'customertest@gmail.com', name: 'Marley Santos', phone: 11990022323)
    assert customer.valid?
  end

  test 'customer with a invalid email should be invalid' do
    customer = Customer.new(email: 'customergmail.com', name: 'Marley Barbosa', phone: 11990022323)
    assert_not customer.valid?
  end

  test 'customer with a invalid phone should be invalid' do
    customer = Customer.new(email: 'customergmail.com', name: 'Marley Barbosa', phone: 11990023)
    assert_not customer.valid?
  end
  test 'customer with a invalid name should be invalid' do
    customer = Customer.new(email: 'customergmail.com', name: 'Marley Barbosa da silva sauro benedito santos pedro da silva', phone: 11990023)
    assert_not customer.valid?
  end
end

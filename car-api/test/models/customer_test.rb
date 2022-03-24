require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'customer with a valid email shoud be valid' do
    customer = Customer.new(email: 'customertest@gmail.com', name: 'Marley Santos', social_security_number: 123_452_393,
                            birth_date: '02-02-1993')
    assert customer.valid?
  end

  test 'customer with a invalid email should be invalid' do
    customer = Customer.new(email: 'customergmail.com', name: 'Marley Barbosa', social_security_number: 123_452_393,
                            birth_date: '02-02-1993')
    assert_not customer.valid?
  end
end

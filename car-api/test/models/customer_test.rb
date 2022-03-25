require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = Customer.new(email: 'jacomagalhaes@gmail.com',
                             name: 'Marley Santos',
                             social_security_number: 1_234_567_891,
                             birth_date: '02-02-1993')
  end

  test 'customer with a valid email should be valid' do
    assert @customer.valid?, @customer.errors.full_messages
  end

  test 'customer with a invalid email should be invalid' do
    customer = Customer.new(email: 'customergmail.com', name: 'Marley Barbosa', social_security_number: 1_234_523_931,
                            birth_date: '02-02-1993')
    assert_not customer.valid?
  end
end

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  setup do
    @customer = customers(:one)
  end

  test 'Address with a valid parameters should be valid' do
    address = Address.new(address: 'Rua Glauber Mendes',
                          address_line_two: 'Floor 2, number 54', number: 230, district: 'Vila Mariana',
                          city: 'São Paulo', state: 'SP', zip_code: '07064030',
                          main_address: false, customer: @customer)

    assert address.valid?, address.errors.full_messages
  end

  test 'car with invalid address shouldn\'t be valid' do
    address = Address.new(address: '',
                          address_line_two: 'Floor 2, number 54', number: 230, district: 'Vila Mariana',
                          city: 'São Paulo', state: 'SP', zip_code: '07064030',
                          main_address: false, customer: @customer)

    assert_not address.valid?, address.errors.full_messages
  end

  test 'car with invalid address line two shouldn\'t be valid' do
    address = Address.new(address: 'Rua Vila lobos',
                          address_line_two: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean ma.', number: 230, district: 'Vila Mariana',
                          city: 'São Paulo', state: 'SP', zip_code: '07064030',
                          main_address: false, customer: @customer)

    assert_not address.valid?, address.errors.full_messages
  end

  test 'car with invalid number shouldn\'t be valid' do
    address = Address.new(address: 'Rua Vila lobos',
                          address_line_two: 'eget dolor. Aenean ma.',
                          number: 230_999, district: 'Vila Mariana',
                          city: 'São Paulo', state: 'SP', zip_code: '07064030',
                          main_address: false, customer: @customer)

    assert_not address.valid?, address.errors.full_messages
  end

  test 'car with invalid district shouldn\'t be valid' do
    address = Address.new(address: 'Rua Vila lobos',
                          address_line_two: '',
                          number: 230_99, district: 'Lorem ipsum dolor sit amet, consectetuer adip',
                          city: 'São Paulo', state: 'SP', zip_code: '07064030',
                          main_address: false, customer: @customer)

    assert_not address.valid?, address.errors.full_messages
  end

  test 'car with invalid city shouldn\'t be valid' do
    address = Address.new(address: 'Rua Vila lobos',
                          address_line_two: '',
                          number: 230_99, district: 'Vila medeiros',
                          city: 'São Paulo Lorem ipsum dolor sit amet, consectetuer adip', state: 'SP', zip_code: '07064030',
                          main_address: false, customer: @customer)

    assert_not address.valid?, address.errors.full_messages
  end

  test 'car with invalid state shouldn\'t be valid' do
    address = Address.new(address: 'Rua Vila lobos',
                          address_line_two: '  ',
                          number: 230_99, district: 'Valida rio',
                          city: 'Belo Horizonte', state: '⠀⠀⠀⠀', zip_code: '07064030',
                          main_address: false, customer: @customer)

    assert_not address.valid?, address.errors.full_messages
  end

  test 'car with invalid zip_code shouldn\'t be valid' do
    address = Address.new(address: 'Rua Vila lobos',
                          address_line_two: '',
                          number: 230_99, district: 'Valida rio',
                          city: 'Belo Horizonte', state: 'RO', zip_code: '',
                          main_address: false, customer: @customer)

    assert_not address.valid?, address.errors.full_messages
  end
end

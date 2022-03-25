require 'test_helper'

class CarTest < ActiveSupport::TestCase
  setup do
    @car = cars(:one)
    @customer = customers(:one)
  end

  test 'car with a valid parameters should be valid' do
    car = Car.new(model: 'Palio', brand: 'Fiat', color: 'Black', year: 2013, customer: @customer)

    assert car.valid?, car.errors.full_messages
  end

  test 'car with invalid model should be valid' do
    car = Car.new(model: 'One morning, when Gregor Samsa woke', brand: 'Fiat', color: 'Black', year: 2013)

    assert_not car.valid?
  end

  test 'car with invalid brand should be valid' do
    car = Car.new(model: 'Palio', brand: 'One morning, when Gregor Samsa woke', color: 'Black', year: 2013)

    assert_not car.valid?
  end

  test 'car with year brand  be valid' do
    car = Car.new(model: 'Palio', brand: 'Fiat', color: 'Black', year: 20_134)

    assert_not car.valid?
  end

  test 'car with invalid color should be valid' do
    car = Car.new(model: 'Palio', brand: 'Fiat', color: 'One morning, when Gregor', year: 20_134)

    assert_not car.valid?
  end
end

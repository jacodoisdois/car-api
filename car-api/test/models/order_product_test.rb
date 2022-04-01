require 'test_helper'

class OrderProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
    @order = orders(:one)
    @product_two = products(:two)
  end

  test 'Order product with valid parameters should be valid' do
    order_product = OrderProduct.new(order: @order, product: @product, total: @product.price * 10,
                                     quantity: 10)

    assert order_product.valid?, order_product.errors.full_messages
  end

  test 'Order product with valid total should be valid' do
    order_product = OrderProduct.create(order: @order, product: @product,
                                        quantity: 10)

    assert_equal order_product.total, order_product.product.price * order_product.quantity
  end

  test 'Order product with invalid total should be invalid' do
    order_product = OrderProduct.new(order: @order, product: @product,
                                     quantity: 10)

    assert_not_equal order_product.total, (order_product.quantity * order_product.product.price) + 100
  end

  test 'Order product with invalid quantity should be invalid' do
    order_product = OrderProduct.new(order: @order, product: @product,
                                     quantity: -1)

    assert_not order_product.valid?, order_product.errors.full_messages
  end

  test 'Order product with valid quantity should be valid' do
    order_product = OrderProduct.new(order: @order, product: @product,
                                     quantity: 10)

    assert order_product.valid?, order_product.errors.full_messages
  end
end

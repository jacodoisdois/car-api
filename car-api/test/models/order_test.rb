require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @customer = customers(:one)

    @product = products(:one)
    @service = services(:one)
  end

  test 'order with valid parameters should be valid' do
    order = Order.new(customer: @customer)

    order.order_products.build({
                                 product: @product, total: @product.price * 10, quantity: 10
                               })
    order.order_services.build({
                                 service: @service, service_duration: 10, scheduled_time: '2022-02-02 10:30'
                               })

    assert order.valid?, order.errors.full_messages
  end
end

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(title: 'Motor fluid 1lt.', description: 'Motor fluid for motors', price: 10.99,
                           quantity: 1)
  end

  test 'product parameters are valid should be valid' do
    assert @product.valid?, @product.errors.full_messages
  end

  test 'product title is invalid shouldn\'t be valid' do
    product_copy = @product
    product_copy.title = 'One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed int'
    assert_not @product.valid?, @product.errors.full_messages
  end

  test 'product description is invalid shouldn\'t be valid' do
    product_copy = @product
    product_copy.description = ' '
    assert_not @product.valid?, @product.errors.full_messages
  end

  test 'product price is invalid shouldn\'t be valid' do
    product_copy = @product
    product_copy.price = 0
    assert_not @product.valid?, @product.errors.full_messages
  end

  test 'product quantity is invalid shouldn\'t be valid' do
    product_copy = @product
    product_copy.quantity = -1
    assert_not @product.valid?, @product.errors.full_messages
  end
end

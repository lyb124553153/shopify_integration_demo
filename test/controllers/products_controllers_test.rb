require 'test_helper'


class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = shops(:regular_shop)
  end

  test 'returns ok' do
    login(@shop)

    ShopifyAPI::Product.expects(:all).returns([])
    get products_url

    assert_response :ok
  end

  test 'pass date to ShopifyAPI::Product' do
    login(@shop)

    date = Date.current
    params = { limit: 20, published_at_min: date.beginning_of_day, published_at_max: date.end_of_day }
    ShopifyAPI::Product.expects(:all).with(params).returns([])
    get products_url, params: { published_at: date }
  end

  test 'ignores invalid date' do
    login(@shop)
    params = { limit: 20 }
    ShopifyAPI::Product.expects(:all).with(params).returns([])
    get products_url, params: { published_at: 'invalid_date' }
  end
end

# frozen_string_literal: true

require 'test_helper'

class HomeIndexHtmlErbTest < ActionDispatch::SystemTestCase

  # Test that products are displayed when published_at date is selected
  test 'products are displayed when published_at date is selected' do
    # Simulate a session token being set
    session_token = 'abc123'
    app_bridge_actions = { SessionToken: { RESPOND: { sessionToken: session_token } } }
    app_bridge_actions_json = app_bridge_actions.to_json
    js_script = "window[\"app-bridge\"] = { actions: #{app_bridge_actions_json} };"
    page.execute_script(js_script)

    # Stub the response from the /products endpoint
    products = [{ id: 1, title: 'Product 1' }, { id: 2, title: 'Product 2' }]
    stub_request(:get, '/products?published_at=2022-01-01')
      .with(headers: { 'Authorization' => 'Bearer abc123' })
      .to_return(status: 200, body: { products: products }.to_json

    # Visit the page and select a date
    visit '/'
    fill_in '#published_at', with: '2022-01-01'

    # Add a wait time to ensure the page has loaded before checking for selectors
    assert_equal 200, page.status_code
    assert_selector 'ul li', count: 2
    assert_selector 'ul li a', text: 'Product 1'
    assert_selector 'ul li a', text: 'Product 2'
  end
end

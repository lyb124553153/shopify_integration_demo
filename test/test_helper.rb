ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"

require "rails/test_help"
require 'capybara/rails'
require 'capybara/minitest'
require 'minitest/unit'
require 'minitest/mock'
require 'mocha/minitest'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end



class ActionDispatch::IntegrationTest
   # Make the Capybara DSL available in all integration tests
   include Capybara::DSL
   # Make `assert_*` methods behave like Minitest assertions
   include Capybara::Minitest::Assertions

  def login(shop)
    stubbed_session = ShopifyAPI::Auth::Session.new(
      shop: shop.shopify_domain,
      access_token: shop.shopify_token,
      is_online: true,
      scope: ShopifyApp.configuration.scope
    )

    ShopifyAPI::Utils::SessionUtils.stubs(:current_session_id).returns("session_id")
    ShopifyApp::SessionRepository.stubs(:load_session).returns(stubbed_session)
  end

  
 
   # Reset sessions and driver between tests
   teardown do
     Capybara.reset_sessions!
     Capybara.use_default_driver
   end
end

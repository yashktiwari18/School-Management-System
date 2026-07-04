ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module AuthenticationHelper
  def login_as(admin)
    post login_path, params: {
      username: admin.username,
      password: "password123"
    }
  end
end

class ActionDispatch::IntegrationTest
  include AuthenticationHelper
end

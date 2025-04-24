ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'devise'

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors, with: :threads)
    fixtures :all

    # For model tests
    setup do
      Warden.test_mode!
    end

    teardown do
      Warden.test_reset!
    end
  end
end

# For integration tests
class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

# For controller tests
class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end
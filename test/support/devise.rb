# test/support/devise.rb
RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
end
require "test_helper"

class ProductFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one) # assuming you have users fixtures
    sign_in @user
    @image_file = fixture_file_upload(Rails.root.join("test/fixtures/files/sample.jpg"), "image/jpeg")
  end

  test "user can create a product" do
    get new_product_path
    assert_response :success

    post products_path, params: {
      product: {
        title: "Integration Test Product",
        description: "Some great description",
        price: 100.50,
        image_url: @image_file
      }
    }

    follow_redirect!
    assert_response :success
    assert_select "h1", "Integration Test Product"
  end
end

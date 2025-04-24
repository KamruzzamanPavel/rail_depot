require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionDispatch::TestProcess::FixtureFile

 setup do
  @user = users(:one)
  sign_in @user

  @image_file = fixture_file_upload('sample.jpg', 'image/jpeg')

  @product = Product.new(
    title: "Ruby Programming Book #{SecureRandom.hex(3)}",
    description: "A comprehensive guide to Ruby programming",
    price: 49.99
  )

  @product.image_url.attach(@image_file)
  @product.save!  # Only save once the image is attached
end

  teardown do
    @product.image_url.purge if @product.image_url.attached?
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: {
        product: {
          title: "New Unique Title #{SecureRandom.hex(4)}",
          description: "A description with more than 10 characters",
          price: 19.99,
          image_url: fixture_file_upload('sample.jpg', 'image/jpeg')
        }
      }
    end
    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        title: "Updated Unique Title #{SecureRandom.hex(4)}",
        description: "Updated description with more than 10 chars",
        price: 29.99,
        image_url: fixture_file_upload('sample.jpg', 'image/jpeg')
      }
    }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end
    assert_redirected_to products_url
  end
end
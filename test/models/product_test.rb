require 'test_helper'
require 'securerandom'

class ProductTest < ActiveSupport::TestCase
  setup do
    @user = User.create(email: 'test@example.com', password: 'password123')
  end 

  teardown do
    @user.destroy if @user.persisted?
    Product.destroy_all  # Clean up products between tests
  end

  def valid_attributes(overrides = {})
    {
      title: "Ruby Programming Book #{SecureRandom.hex(4)}",
      description: 'A comprehensive guide to Ruby programming with examples',
      price: 49.99
    }.merge(overrides)
  end

  def attach_valid_image(product)
    product.image_url.attach(
      io: File.open(Rails.root.join('test/fixtures/files/sample.jpg')),
      filename: 'sample.jpg',
      content_type: 'image/jpeg'
    )
  end

  def attach_invalid_image(product)
    product.image_url.attach(
      io: File.open(Rails.root.join('test/fixtures/files/sample.txt')),
      filename: 'sample.txt',
      content_type: 'text/plain'
    )
  end

  test 'should be valid with correct attributes' do
    product = Product.new(valid_attributes)
    attach_valid_image(product)
    assert product.save
  end

  test 'should require title' do
    product = Product.new(valid_attributes(title: ''))
    attach_valid_image(product)
    assert_not product.valid?
    assert_includes product.errors[:title], "can't be blank"
  end

  test 'should require unique title' do
    attrs = valid_attributes(title: 'Unique Title')
    existing = Product.new(attrs)
    attach_valid_image(existing)
    assert existing.save

    product = Product.new(attrs)
    attach_valid_image(product)
    assert_not product.valid?
    assert_includes product.errors[:title], 'has already been taken'
  end

  test 'should require description' do
    product = Product.new(valid_attributes(description: ''))
    attach_valid_image(product)
    assert_not product.valid?
    assert_includes product.errors[:description], "can't be blank"
  end

  test 'should require description to be at least 10 characters' do
    product = Product.new(valid_attributes(description: 'Short'))
    attach_valid_image(product)
    assert_not product.valid?
    assert_includes product.errors[:description], 'is too short (minimum is 10 characters)'
  end

  test 'should require price' do
    product = Product.new(valid_attributes(price: nil))
    attach_valid_image(product)
    assert_not product.valid?
    assert_includes product.errors[:price], "can't be blank"
  end

  test 'should require positive price' do
    product = Product.new(valid_attributes(price: -1))
    attach_valid_image(product)
    assert_not product.valid?
    assert_includes product.errors[:price], 'must be greater than or equal to 0.01'
  end

  test 'should require attached image_url' do
    product = Product.new(valid_attributes)
    assert_not product.valid?
    assert_includes product.errors[:image_url], 'must be attached'
  end

  test 'should accept valid image attachment' do
    product = Product.new(valid_attributes)
    attach_valid_image(product)
    assert product.save
  end

  test 'should reject invalid image content type' do
    product = Product.new(valid_attributes)
    attach_invalid_image(product)
    assert_not product.valid?
    assert_includes product.errors[:image_url], 'must be a PNG or JPG image.'
  end

  test 'should format price correctly' do
    product = Product.new(valid_attributes(price: 19.99))
    attach_valid_image(product)
    assert_equal '$19.99', product.formatted_price
  end

  test 'image_url validation message for wrong content type' do
    product = Product.new(valid_attributes)
    attach_invalid_image(product)
    product.valid?
    assert_equal ['must be a PNG or JPG image.'], product.errors[:image_url]
  end
end

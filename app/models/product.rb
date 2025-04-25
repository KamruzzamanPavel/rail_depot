class Product < ApplicationRecord
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  has_one_attached :image_url

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, presence: true
  validates :title, uniqueness: true
  validates :description, length: { minimum: 10 }

  validate :image_url_must_be_valid

  def formatted_price
    "$#{'%.2f' % price}"
  end

  private

  def image_url_must_be_valid
    if image_url.attached?
      unless image_url.content_type.in?(%w[image/png image/jpeg])
        errors.add(:image_url, 'must be a PNG or JPG image.')
      end
    else
      errors.add(:image_url, 'must be attached')
    end
  end
  # Ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end 
end

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  validates :product, presence: true
  validates :cart, presence: true
end

class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_categories, dependent: :delete_all
  has_many :categories, through: :product_categories
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :reviews, dependent: :destroy
  validates :product_title, presence: true, length: { minimum: 6, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 3000 }
  validates :sku_id, presence: true, uniqueness: true, numericality: { greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :category_ids, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :weight_unit, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows alphabetic characters" }
  has_one_attached :image
  validate :image_presence

  def image_presence
    errors.add(:image, "must be attached") unless image.attached?
  end

  def category=(category)
    self.category_ids = [category.id]
  end 
end
class Product < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :reviews

  validates :product_title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 3000}
  validates :sku_id, presence: true
  validates :weight, presence: true
  validates :price, presence: true, length: {maximum: 10}
  has_one_attached :image
  validates :image, presence: true
end
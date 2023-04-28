class Product < ApplicationRecord
    has_and_belongs_to_many :categories
    has_many :cart_items, dependent: :destroy
    has_many :carts, through: :cart_items
    validates :product_title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 3000}
    validates :sku_id, presence: true
    validates :price, presence: true, length: {maximum: 10}
    has_one_attached :image
    validates :image, presence: true
    validates_associated :categories
  end
  
  
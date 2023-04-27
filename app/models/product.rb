class Product < ApplicationRecord
    has_and_belongs_to_many :categories
    validates :product_title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 3000}
    validates :sku_id, presence: true
    validates :price, presence: true, length: {maximum: 10}
    has_one_attached :image
    validates :image, presence: true
    def search
        key = "%#{params[:key]}%"
        @posts = Post.where("name LIKE ?", key)
    end
end
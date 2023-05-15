class SalesReport < ApplicationRecord
    belongs_to :shop
    belongs_to :category
    validates :date_of_purchase, :total_price, :product_name, :price, :quantity, :category_id, presence: true
  end

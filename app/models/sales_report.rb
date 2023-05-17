class SalesReport < ApplicationRecord
    belongs_to :shop
    belongs_to :category
    has_one :accounting
    validates :date_of_purchase, :weight, :total_price, :product_name, :price, :quantity, :category_id, presence: true
  end

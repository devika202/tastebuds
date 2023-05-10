class SalesReport < ApplicationRecord
    belongs_to :shop
    belongs_to :product
    belongs_to :category

    validates :date, :time, :amount, presence: true
  end

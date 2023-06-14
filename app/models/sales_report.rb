class SalesReport < ApplicationRecord
  belongs_to :shop
  belongs_to :category
  has_one :accounting, dependent: :destroy
  after_create :create_accounting
  validates :date_of_purchase, :product_name, :category_id, presence: true
  validates :price,:total_price,:quantity, :weight, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :weight_unit , presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows alphabetic characters" }  
  
  def create_accounting
    Accounting.create(sales_report: self)
  end
end

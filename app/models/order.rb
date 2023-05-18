class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :accounting, dependent: :destroy
  has_many :products, through: :order_items, source: :product
  enum status: { pending: 0, processing: 1, shipped: 2, delivered: 3 }
  after_create :create_accounting
  belongs_to :sales_report, optional: true

  def create_accounting
    Accounting.create(order: self, sales_report: self.sales_report)
  end
  def create_order_items(cart_items)
    cart_items.each do |cart_item|
      order_item = order_items.build(product: cart_item.product_title, quantity: cart_item.quantity, price: cart_item.product.price)
      order_item.save
    end
  end
  
  def total_price
    order_items.sum(&:total_price)
  end
  def price
    order_items.inject(0) { |sum, item| sum + item.quantity * item.product.price }
  end

  validates :shipping_name, presence: true
  validates :shipping_address, presence: true
  validates :shipping_city, presence: true
  validates :shipping_state, presence: true
  validates :shipping_zipcode, presence: true, length: { minimum: 5, maximum: 9 }
  validates :payment_method, presence: true
end

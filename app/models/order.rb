class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items, source: :product
  
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
end

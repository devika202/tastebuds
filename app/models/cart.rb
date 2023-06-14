class Cart < ApplicationRecord
  include Cartable
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items, dependent: :destroy
  
  def clear_cart
    cart_items.destroy_all
  end

  def total_price
    cart_items.sum(&:total_price)
  end
    
  def add_item(product_id)
    item = cart_items.find_or_initialize_by(product_id: product_id)
    item.quantity ||= 0 
    item.quantity += 1
    item.save!
  end
    
  def remove_item(product_id)
    item = cart_items.find_by(product_id: product_id)
    if item.quantity > 1
      item.quantity -= 1
      item.save!
    else
      item.destroy
    end
  end
   
end
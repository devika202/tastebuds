class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  
  def total_price
    if product
      product.price * quantity
    else
      0
    end
  end
  
end
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  
  def total_price
    if product && product.price.present? && quantity.present?
      product.price * quantity
    else
      BigDecimal(0)
    end
  end
end
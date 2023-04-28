class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    has_many :products, through: :cart_items
    
    def add_item(product_id)
      item = cart_items.find_or_initialize_by(product_id: product_id)
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
    
    def clear
      cart_items.destroy_all
    end
    
    def total_price
      cart_items.to_a.sum(&:total_price)
    end
  end
  
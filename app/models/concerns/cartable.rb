module Cartable
    extend ActiveSupport::Concern
  
    def clear_cart
      cart_items.destroy_all
    end
  end
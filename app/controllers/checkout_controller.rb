class CheckoutController < ApplicationController
    def new
        @order = current_user.orders.build
    end
  
    def create
      @order = current_user.orders.build(order_params)
      if @order.save
        redirect_to products_path, notice: 'Order was successfully placed.'
      else
        render 'new'
      end
    end
    
    private
  
    def order_params
      params.require(:order).permit(:shipping_name, :shipping_address, :shipping_city, :shipping_state, :shipping_zipcode, :payment_method)
    end
  end
  
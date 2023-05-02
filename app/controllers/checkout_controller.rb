class CheckoutController < ApplicationController
  before_action :set_cart
  include Cartable
  def new
    @order = Order.new
  end
  
  def create
    @order = current_user.orders.build(order_params)
  
    if @order.save
      # Create OrderItems for each CartItem
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create(product: cart_item.product, quantity: cart_item.quantity)
      end
  
      # Clear the cart after creating the order
      current_user.cart.clear_cart
  
      # Redirect to the order confirmation page
      redirect_to order_confirmation_path(@order)
    else
      # Handle errors and show the checkout form again
      render :new
    end
  end
  
  private

  def set_cart
    @cart = current_user.cart || Cart.new
  end
  
  def order_params
    params.require(:order).permit(:shipping_name, :shipping_address, :shipping_city, :shipping_state, :shipping_zipcode, :payment_method)
  end
end
class CheckoutController < ApplicationController
  before_action :set_cart
  include Cartable
  def new
    if current_user.cart.cart_items.empty?
      flash[:notice] = "Your cart is empty. Please add some products to proceed to checkout."
      redirect_to products_path
    else
      @order = Order.new
    end
  end
  
  

  def create
    if order_params.present?
      @order = current_user.orders.build(order_params)
      @order.status = "pending"
      if @order.save
        current_user.cart.cart_items.each do |cart_item|
          @order.order_items.create(product: cart_item.product, quantity: cart_item.quantity)
        end
        current_user.cart.clear_cart
        redirect_to order_confirmation_path(@order)
      else
        render :new
      end
    else
      flash.now[:notice] = "Please fill in your shipment details to proceed to checkout."
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
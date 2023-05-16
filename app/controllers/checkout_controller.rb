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
          product = cart_item.product
          quantity_purchased = cart_item.quantity
          remaining_quantity = product.quantity - quantity_purchased
  
          if remaining_quantity >= 0
            product.update(quantity: remaining_quantity)
            @order.order_items.create(product: product, quantity: quantity_purchased)
          else
            flash[:notice] = "Insufficient quantity for product: #{product.product_title}. Available quantity: #{product.quantity}"
            redirect_to products_path and return
          end          
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
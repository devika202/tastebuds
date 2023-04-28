class CartsController < ApplicationController
    before_action :authenticate_user!
    def create
        @cart = current_user.cart || current_user.build_cart
        @cart.cart_items.build(product_id: params[:cart][:product_id])
        if @cart.save
          redirect_to cart_path(@cart), notice: 'Product was successfully added to cart.'
        else
          redirect_to root_path, alert: 'Unable to add product to cart.'
        end
      end
    def show
      @cart = current_user.cart
    end
    
    def add_item
      @cart = current_user.cart
      @product = Product.find(params[:product_id])
      @cart.add_item(@product.id)
      redirect_to @product, notice: 'Product added to cart'
    end
    
    def remove_item
      @cart = current_user.cart
      @product = Product.find(params[:product_id])
      @cart.remove_item(@product.id)
      redirect_to @cart, notice: 'Product removed from cart'
    end
    
    def clear
      @cart = current_user.cart
      @cart.clear
      redirect_to @cart, notice: 'Cart cleared'
    end
  end
  
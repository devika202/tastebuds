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
  
  def update
      @cart = current_user.cart || Cart.new(user: current_user)
      @product = Product.find(params[:cart][:product_id])
      @cart.add_item(@product.id)
      redirect_to cart_path(@cart)
  end
    

  def add_item
      @cart = current_user.cart || Cart.create(user: current_user)
      @product = Product.find(params[:product_id])
      @cart.add_item(@product.id)
      redirect_to @product, notice: 'Product added to cart'
  end

    
  def remove_item
      @cart = current_user.cart
      @cart.remove_item(params[:id])
      redirect_to cart_path
  end
    
  def clear_cart
      @cart = current_user.cart
      @cart.cart_items.destroy_all
      redirect_to cart_path(@cart)
  end
end
  
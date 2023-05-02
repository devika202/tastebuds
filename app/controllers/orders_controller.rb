class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def order_confirmation
    @order = Order.find(params[:id])
    render 'order_confirmation'
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
end

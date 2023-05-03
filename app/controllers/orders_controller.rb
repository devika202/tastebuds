class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:order_confirmation]
  
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
  
  private
  
  def correct_user
    @order = current_user.orders.find_by(id: params[:id])
    redirect_to root_url if @order.nil?
  end
end

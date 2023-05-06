class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      @orders = Order.all
    end
  
    def show
      @order = Order.find(params[:id])
    end
  
    def update
      @order = Order.find(params[:id])
      @order.update(order_params)
      redirect_to admin_order_path(@order)
    end

    def edit
      @order = Order.find(params[:id])
    end
    
  
    private
  
    def order_params
      params.require(:order).permit(:status)
    end
  
    def authenticate_admin!
      redirect_to root_path unless current_user.admin?
    end
  end
  
class AdminController < ApplicationController
    before_action :authenticate_admin
  
    def authenticate_admin
      unless current_user.admin?
        flash[:error] = "You must be an admin to access this page"
        redirect_to root_path
      end
    end
  
    def new_shop
      @shop = Shop.new
    end
  
    def create_shop
      @shop = Shop.new(shop_params)
      if @shop.save
        redirect_to root_path, notice: 'Shop was successfully created.'
      else
        render :new_shop
      end
    end
  
    private
  
    def shop_params
      params.require(:shop).permit(:name, :email, :password, :password_confirmation)
    end
  end
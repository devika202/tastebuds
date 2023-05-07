class ShopsController < ApplicationController
    def login
    end
    
    def sales
        @sales = current_shop.sales
      end
      
    
    def new
      @shop = Shop.new
    end
  
    def create
      @shop = Shop.new(shop_params)
      if @shop.save
        flash[:success] = "Shop registration successful."
        redirect_to shop_login_path
      else
        render :new
      end
    end
  
    private
  
    def shop_params
      params.require(:shop).permit(:name, :address, :phone_number, :email, :password, :password_confirmation)
    end
  end
  
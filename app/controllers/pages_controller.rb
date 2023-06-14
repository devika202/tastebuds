class PagesController < ApplicationController

    def home
        @search = Product.ransack(params[:q])
        @current_shop = current_shop
    end
    
    def about
       
    end
end

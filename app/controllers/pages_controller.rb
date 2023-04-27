class PagesController < ApplicationController
    def home
        @search = Product.ransack(params[:q])
    end
    
end

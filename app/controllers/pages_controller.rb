class PagesController < ApplicationController
    def home
        @search = Product.ransack(params[:q])
    end
    def about
       
    end
end

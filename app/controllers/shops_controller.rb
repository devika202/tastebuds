class ShopsController < ApplicationController
    before_action :require_login, except: [:login, :index]
    include Rails.application.routes.url_helpers

    def dashboard
        @shop = current_shop
    end
      
    def index
      @shops = Shop.all
    end
    
    def login
        shop = Shop.find_by(email: params[:email])
        if shop&.authenticate(params[:password])
          session[:shop_id] = shop.id
          redirect_to root_path
          flash[:notice] = "Logged in successfully!"
        else
          render 'login'
          flash[:error] = 'Invalid email or password'
        end
    end
      
    
    def logout
    session[:shop_id] = nil
    redirect_to root_path
    end
      
    private
  
    def require_login
      unless current_shop
        redirect_to '/shops/login'
      end
    end
  
    def current_shop
      @current_shop ||= Shop.find(session[:shop_id]) if session[:shop_id]
    end
  end
  
class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :current_user ,:user_signed_in?
    protect_from_forgery with: :exception
    before_action :authenticate_admin!, if: :admin_controller?
    helper_method :current_shop

    def admin_controller?
      params[:controller].split('/').first == 'admin'
    end

    def user_signed_in?
        !!current_user
    end
    
    def require_user
        if !user_signed_in?
        flash[:alert] = "You must be logged in to perform that action"
        redirect_to login_path
        end
    end

    private

    def current_shop
        @current_shop ||= Shop.find_by(id: session[:shop_id]) if session[:shop_id]
    end
   
    protected

    def current_admin
        @current_admin ||= current_user&.admin? ? current_user : nil
    end

    def authenticate_admin!
        unless current_admin
            flash[:error] = "You must be an admin to access this page"
            redirect_to root_path
        end
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :phone, :address, :username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :phone, :address, :username])
    end
    
end
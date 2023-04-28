class ApplicationController < ActionController::Base
    helper_method :current_user ,:user_signed_in?
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def user_signed_in?
        !!current_user
    end
    
    def require_user
        if !user_signed_in?
        flash[:alert] = "You must be logged in to perform that action"
        redirect_to login_path
        end
    end

  
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :phone, :address, :username])
    end
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :phone, :address, :username])
    end
    
end
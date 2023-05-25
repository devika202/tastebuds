class RegistrationsController < Devise::RegistrationsController
    respond_to :html, :json
    def edit
        if current_user.admin?
          @user = User.find(params[:id])
          @search = Product.ransack(params[:q])
          # Render the edit view for the selected user
        elsif current_user == User.find(params[:id])
          @user = current_user
          @search = Product.ransack(params[:q])
          # Render the edit view for the current user
        else
          flash[:alert] = "Access denied. You can only edit your own profile or as an admin."
          redirect_to root_path
        end
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "User not found."
        redirect_to root_path
      end
      

      
      
  end
  
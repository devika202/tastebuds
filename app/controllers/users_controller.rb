class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
    @search = Product.ransack(params[:q])
    if current_user && (current_user == @user || current_user.admin?)
    else
      flash[:alert] = "Access denied. You can only view your own profile or as an admin."
      redirect_to root_path
    end
  end
    
    

  def index
    @users = User.all
    @search = Product.ransack(params[:q])
    if current_user && current_user.admin?
      @users = User.paginate(page: params[:page], per_page: 3)
    else
      flash[:alert] = "Only admins can view the users list."
      redirect_to root_path
    end
  end
    

  def new
      @user = User.new
      @search = Product.ransack(params[:q])
  end

  def edit
    if current_user.admin?
      @user = User.find(params[:id])
      @search = Product.ransack(params[:q])
      if @user
      else
        flash[:alert] = "User not found."
        redirect_to root_path
      end
    elsif current_user == User.find(params[:id])
      @user = current_user
      @search = Product.ransack(params[:q])
    else
      flash[:alert] = "Access denied. You can only edit your own profile or as an admin."
      redirect_to root_path
    end
  end
  
  def create
    @search = Product.ransack(params[:q])
    @user = User.new(user_params)
    if @user.save
      user_signed_in?
      flash[:notice] = "Welcome, #{user_params[:firstname]}! You have successfully created your account."
      session[:user_id] = @user.id
      redirect_to root_path 
    else
      p @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end
  
    
  def logged_in_user
    redirect_to root_path
  end

  def update
      if @user.update(user_params)
          flash[:notice] = "User data updated successfully"
          redirect_to @user
      else
          render :edit, status: :unprocessable_entity
      end
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy 
      redirect_to users_path
  end

  private

  def set_user
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :phone, :address, :email, :username, :password, :password_confirmation)
  end
  

end
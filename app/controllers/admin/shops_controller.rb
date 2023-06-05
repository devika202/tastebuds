class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_shop, only: [:edit, :update, :destroy]

  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)

    if @shop.save
      redirect_to admin_shops_path, notice: 'Shop was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to admin_shops_path, notice: 'Shop was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    redirect_to admin_shops_path, notice: 'Shop was successfully deleted.'
  end

  private

  def authenticate_admin
    unless current_user.admin?
      flash[:error] = "You must be an admin to access this page"
      redirect_to root_path
    end
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :email, :location, :contact_info, :password, :password_confirmation)
  end
end
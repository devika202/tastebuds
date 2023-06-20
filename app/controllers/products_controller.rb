class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_admin, only: [:edit,:new, :update, :destroy]

  def show
    @product = Product.includes(:categories).find(params[:id])
    @search = Product.ransack(params[:q])
    @review = Review.new(product: @product)
  
    if user_signed_in?
      @cart = current_user.cart || current_user.build_cart
    else
      @cart = Cart.new
    end
  
    if @product.quantity.to_i <= 0
      @availability_message = "Product Unavailable"
    else
      @availability_message = "Product Available"
    end
  end
  
  
  def index
    @products = Product.all
    @search = Product.includes(:categories).ransack(params[:q])
    @products = @search.result.includes(:categories).paginate(page: params[:page], per_page: 9)
    @categories = Category.all
    if user_signed_in?
      @cart = current_user.cart || current_user.build_cart
    else
      @cart = Cart.new
    end
  
  end
  
  
  def new
      @product = Product.new
      @search = Product.ransack(params[:q])
  end

  def edit
    @search = Product.ransack(params[:q])
  end

  def create
    if current_user.admin?
      @product = Product.new(product_params)
      @product.image.attach(params[:product][:image])
      @product.user_id = current_user.id
      if @product.save
        flash[:notice] = "Product was created successfully."
        redirect_to @product 
      else
        p @product.errors.full_messages
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "Only admins can create new products"
      redirect_to root_path
    end
  end
  
    
  def update
    if params[:product][:image].present?
      @product.image.attach(params[:product][:image])
      @product.image.purge_later 
    end
  
    if @product.update(product_params)
      flash[:notice] = "Product updated successfully"
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
      @product.destroy 
      redirect_to products_path
  end

  private

  

  def set_product
      @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_title,:weight,:weight_unit, :quantity ,:description, :sku_id, :price, :image,  category_ids: [])
  end

  def require_admin
    unless current_user.admin?
      flash[:alert] = "Only admins can perform this action"
      redirect_to root_path
    end
  end
    
end
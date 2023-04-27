class CategoriesController < ApplicationController
    before_action :require_admin, only: [:new,:index, :create, :edit, :update, :destroy]

    def new 
        @category = Category.new
        @search = Product.ransack(params[:q])
    end
    
    def create 
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category was successfully created"
            redirect_to @category
        else
            render "new"
        end
    end

    def show
        @category = Category.find(params[:id])
        @search = Product.ransack(params[:q])
        if user_signed_in? && current_user.admin?
          @products = @category.products.paginate(page: params[:page], per_page: 3)
        else
          flash[:alert] = "Only admins can perform this action."
          redirect_to root_path
        end
      end

    def edit
        @search = Product.ransack(params[:q])
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:notice] = "Category name updated succeddfully"
            redirect_to @category
        else
            render 'edit'
        end
    end

    def destroy
        @category = Category.find(params[:id])
        if @category.present?
          @category.products.destroy_all
          @category.destroy
          redirect_to categories_path, notice: "Category and associated products were successfully deleted."
        else
          redirect_to categories_path, alert: "Category not found."
        end
      end

    
    def index
        @search = Product.ransack(params[:q]) 
        @categories = Category.paginate(page: params[:page], per_page: 3)
    end
    
    private
    
    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        unless user_signed_in? && current_user.admin?
            flash[:alert] = "Only admins can perform this action"
            redirect_to categories_path
        end
    end
end

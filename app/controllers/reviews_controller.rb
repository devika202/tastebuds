class ReviewsController < ApplicationController
    before_action :authenticate_user!, except: [:create]    
    before_action :authenticate_admin!, only: [:destroy]  
    def create
      @product = Product.find(params[:product_id])
      @review = @product.reviews.build(review_params)
      @review.user = current_user if user_signed_in?
  
      if @review.save
        redirect_to @product
      else
        render 'products/show'
      end
    end

    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        redirect_back(fallback_location: root_path)
    end
  
    private
  
    def review_params
        params.require(:review).permit(:content)
    end
    def authenticate_admin!
        unless current_user&.admin?
          flash[:alert] = "You don't have permission to do that."
          redirect_back(fallback_location: root_path)
        end
    end
  
  end
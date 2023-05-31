class ShopSalesReportsController < ApplicationController
  before_action :authorize_current_shop, only: [:index]
  before_action :authorize_admin, only: [:admin_index]

  def index
    @sales_reports = current_shop.sales_reports
  end

  def new
    @sales_report = current_shop.sales_reports.build
    @categories = Category.all
  end

  def create
    @sales_report = current_shop.sales_reports.build(sales_report_params)
    if @sales_report.save
      flash[:success] = "Sales report added successfully!"
      redirect_to shop_dashboard_path
    else
      @categories = Category.all
      puts @sales_report.errors.full_messages 
      render :new
    end
  end

  def edit
    @sales_report = current_shop.sales_reports.find(params[:id])
    @categories = Category.all
  end

  def update
    @sales_report = current_shop.sales_reports.find(params[:id])
    if @sales_report.update(sales_report_params)
      flash[:success] = "Sales report updated successfully!"
      redirect_to shop_sales_reports_path
    else
      @categories = Category.all
      puts @sales_report.errors.full_messages 
      render :edit
    end
  end

  def destroy
    @sales_report = current_shop.sales_reports.find(params[:id])
    @sales_report.destroy
    flash[:success] = "Sales report deleted successfully!"
    redirect_to shop_sales_reports_path
  end

  def admin_index
    @search = SalesReport.ransack(params[:q])
    @sales_reports = @search.result(distinct: true).includes(:shop, :category).order(date_of_purchase: :desc)
  
    if params[:q] && params[:q][:shop_name_or_category_name_cont].present?
      name_or_category = "%#{params[:q][:shop_name_or_category_name_cont]}%"
      @sales_reports = @sales_reports.where(
        'sales_reports.product_name LIKE ? OR shops.name LIKE ? OR categories.name LIKE ?',
        name_or_category, name_or_category, name_or_category
      )
    end
    
  end

  private

  def sales_report_params
    params.require(:sales_report).permit(:product_name,:weight_unit, :weight, :price, :quantity, :total_price, :date_of_purchase, :category_id)
  end

  def authorize_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end

  def authorize_current_shop
    unless current_shop
      flash[:alert] = "You are not authorized to view this page."
      redirect_to root_path
    end
  end
end

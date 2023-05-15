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
    @sales_reports = SalesReport.all
  end
  

  private

  def sales_report_params
    params.require(:sales_report).permit(:product_name, :price, :quantity, :total_price, :date_of_purchase, :category_id)
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

class SalesReportsController < ApplicationController
    before_action :authenticate_shop

    def new_sales_report
      @sales_report = SalesReport.new
      @products = Product.all
      @categories = Category.all
    end

    def create_sales_report
      @sales_report = SalesReport.new(sales_report_params)
      @sales_report.shop_id = current_shop.id 
      if @sales_report.save
        redirect_to root_path, notice: 'Sales report was successfully created.'
      else
        render :new_sales_report
      end
    end

    private

    def sales_report_params
      params.require(:sales_report).permit(:date, :time, :amount, :product_id, :category_id)
    end
  end

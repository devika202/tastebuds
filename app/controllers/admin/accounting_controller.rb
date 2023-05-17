class Admin::AccountingController < ApplicationController
  def index
    @accounting_records = Accounting.includes(:order, :sales_report).all
    @orders = Order.all
    @sales_reports = SalesReport.all
  end

  def new
    @accounting_record = Accounting.new
    @accounting_records = []
    @orders = Order.all 
    @sales_reports = SalesReport.all
  end


  def create
    @accounting_record = Accounting.new(accounting_params)
    @orders = Order.all
    @sales_reports = SalesReport.all
    
    if @accounting_record.save
      flash[:success] = "Accounting record added successfully!"
      redirect_to admin_accounting_index_path
    else
      flash[:error] = "Failed to create accounting record."
      render :new
    end
  end
  

  def edit
    @accounting_record = Accounting.find(params[:id])
  end

  def update
    @accounting_record = Accounting.find(params[:id])
    if @accounting_record.update(accounting_params)
      flash[:success] = "Accounting record updated successfully!"
      redirect_to admin_accounting_index_path
    else
      render :edit
    end
  end

  private

  def accounting_params
    params.require(:accounting).permit(:source, :identifier, :order_id, :sales_report_id, :amount)
  end

end

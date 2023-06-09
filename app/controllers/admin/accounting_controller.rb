class Admin::AccountingController < ApplicationController
  def index
    @accounting_records = Accounting.includes(:order, :sales_report).all
    @orders = Order.all
    @sales_reports = SalesReport.all
  
    if params[:from_date].present?
      from_date = Date.parse(params[:from_date]).beginning_of_day
      @accounting_records = @accounting_records.where("created_at >= ?", from_date)
    end
  
    if params[:to_date].present?
      to_date = Date.parse(params[:to_date]).end_of_day
      @accounting_records = @accounting_records.where("created_at <= ?", to_date)
    end
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
  

  def destroy
    @accounting_record = Accounting.find(params[:id])
    @accounting_record.destroy
    redirect_to admin_accounting_index_path, notice: 'Accounting record was successfully destroyed.'
  end
  

  private

  def accounting_params
    params.require(:accounting).permit(:source, :identifier, :order_id, :sales_report_id, :amount)
  end

end
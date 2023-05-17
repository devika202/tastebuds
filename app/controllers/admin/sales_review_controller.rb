class Admin::SalesReviewController < ApplicationController
    def index
      @accounting_records = Accounting.includes(:order, :sales_report).all
    end
end
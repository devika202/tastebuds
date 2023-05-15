class AddDateOfPurchaseToSalesReports < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_reports, :date_of_purchase, :date
  end
end

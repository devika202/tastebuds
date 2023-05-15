class DropSalesReportsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :sales_reports
  end
end

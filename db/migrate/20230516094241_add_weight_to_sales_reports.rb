class AddWeightToSalesReports < ActiveRecord::Migration[5.2]
  def change
    add_column :sales_reports, :weight, :string
  end
end

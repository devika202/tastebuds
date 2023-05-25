class ChangeWeightInSalesReports < ActiveRecord::Migration[5.2]
  def change
    change_column :sales_reports, :weight, :integer
    add_column :sales_reports, :weight_unit, :string
  end
end
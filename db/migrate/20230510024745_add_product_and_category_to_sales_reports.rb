class AddProductAndCategoryToSalesReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales_reports, :product, foreign_key: true
    add_reference :sales_reports, :category, foreign_key: true
  end
end

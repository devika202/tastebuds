class CreateSalesReports < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_reports do |t|
      t.references :shop, foreign_key: true
      t.date :date
      t.time :time
      t.float :amount
    end
  end
end

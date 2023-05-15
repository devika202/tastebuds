class CreateSalesReports < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_reports do |t|
      t.string :product_name
      t.decimal :price
      t.integer :quantity
      t.decimal :total_price
      t.integer :category_id
      t.date :purchase_date
      t.integer :shop_id
    end
  end
end

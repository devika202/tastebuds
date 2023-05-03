class ChangePriceAndQuantityDataTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :price, :decimal, precision: 10, scale: 2
    change_column :cart_items, :quantity, :integer
  end
  
end

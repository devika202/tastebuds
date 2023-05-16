class ClearQuantityDataInProducts < ActiveRecord::Migration[5.2]
  def up
    Product.update_all(quantity: nil)
  end
end

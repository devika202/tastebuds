class ChangeQuantityToIntegerAndAddWeightToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :quantity, :integer
    add_column :products, :weight, :string
  end
end

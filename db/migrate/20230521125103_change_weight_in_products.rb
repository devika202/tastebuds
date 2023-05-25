class ChangeWeightInProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :weight, :integer
    add_column :products, :weight_unit, :string
  end
end

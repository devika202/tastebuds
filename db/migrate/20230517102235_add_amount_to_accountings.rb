class AddAmountToAccountings < ActiveRecord::Migration[5.2]
  def change
    add_column :accountings, :amount, :decimal
  end
end

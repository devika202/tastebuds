class ChangeStatusColumnInOrdersTable < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :status, :integer
  end

  def down
    change_column :orders, :status, :string
  end
end

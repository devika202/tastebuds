class AddPasswordToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :password, :string
  end
end

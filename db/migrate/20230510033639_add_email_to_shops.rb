class AddEmailToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :email, :string
  end
end

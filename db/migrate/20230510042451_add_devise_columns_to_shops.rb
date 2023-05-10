class AddDeviseColumnsToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :encrypted_password, :string
    add_column :shops, :reset_password_token, :string
  end
end

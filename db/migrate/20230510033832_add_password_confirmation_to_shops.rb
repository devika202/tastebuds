class AddPasswordConfirmationToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :password_confirmation, :string
  end
end

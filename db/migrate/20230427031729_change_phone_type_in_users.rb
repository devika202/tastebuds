class ChangePhoneTypeInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :phone, :bigint
  end
end

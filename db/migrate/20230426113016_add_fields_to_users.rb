class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :phone, :integer
    add_column :users, :address, :text
    add_column :users, :username, :string
  end
end

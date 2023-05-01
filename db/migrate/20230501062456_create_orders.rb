class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :shipping_name
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zipcode
      t.string :payment_method
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

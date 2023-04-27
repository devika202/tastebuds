class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

    t.string :product_title
    t.text :description
    t.integer :sku_id
    t.integer :price
    end
  end
end

class CreateJoinTableCategoryProduct < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :products do |t|
      # t.index [:category_id, :product_id]
      # t.index [:product_id, :category_id]
      t.references :category, null: false, foreign_key: true, on_delete: :delete_all
      t.references :product, null: false, foreign_key: true, on_delete: :delete_all
    end
  end
end


class AddSourceToAccountings < ActiveRecord::Migration[5.2]
  def change
    add_column :accountings, :source, :string
  end
end

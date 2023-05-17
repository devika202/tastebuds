class CreateAccounting < ActiveRecord::Migration[5.2]
  def change
    create_table :accountings do |t|
      t.references :order, foreign_key: true
      t.references :sales_report, foreign_key: true
      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end

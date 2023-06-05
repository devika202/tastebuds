FactoryBot.define do
    factory :sales_report do
      product_name { "Sample Product" }
      price { 10.0 }
      quantity { 1 }
      total_price { 10.0 }
      category
      purchase_date { Date.today }
      shop
      date_of_purchase { Date.today }
      weight { 1 }
      weight_unit { "kg" }
      order_id { association :order }
    end
  end
  
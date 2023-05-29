FactoryBot.define do
  factory :product do
    sequence(:product_title) { |n| "Product #{n}" }
    description { "Sample description" }
    sku_id { 1 }
    price { 10.0 }
    user_id { 4 }
    quantity { 5 }
    weight { 200 }
    weight_unit { "gm" }
    category_ids { association(:category).id }  
  end
end

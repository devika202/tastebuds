FactoryBot.define do
  factory :product do
    sequence(:product_title) { |n| "Product #{n}" }
    description { "Sample description" }
    sequence(:sku_id) { |n| n }
    price { 10.0 }
    user_id { 4 }
    quantity { 5 }
    weight { 200 }
    weight_unit { "gm" }
    category { association(:category) } 
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('app', 'assets', 'images', 'download.jpg'),
        'image/jpeg'
      )
    end
  end
end

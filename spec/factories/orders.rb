FactoryBot.define do
    factory :order do
    end
  end
    
  FactoryBot.define do
    factory :order_item do
      association :order
      association :product
      quantity { 1 }
    end
  end
FactoryBot.define do
  factory :order do
    user
    shipping_name { "Devika" }
    shipping_address { "Kollam, kerala" }
    shipping_city { "City" }
    shipping_state { "State" }
    shipping_zipcode { "12345" }
    payment_method { "Credit Card" }
  end
end

  FactoryBot.define do
    factory :order_item do
      association :order
      association :product
      quantity { 1 }
    end
  end

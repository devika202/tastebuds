FactoryBot.define do
    factory :review do
      content { "Sample review content" }
      association :product
      association :user
    end
  end
  
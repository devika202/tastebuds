FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    created_at { "2023-04-27 04:09:20" }
    updated_at { "2023-05-16 07:02:47" }
  end
end

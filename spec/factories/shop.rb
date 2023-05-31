FactoryBot.define do
    factory :shop do
      sequence(:name) { |n| "Shop #{n}" }
      sequence(:location) { |n| "Location #{n}" }
      sequence(:contact_info) { |n| "Contact Info #{n}" }
      sequence(:email) { |n| "shop#{n}@example.com" }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end
  
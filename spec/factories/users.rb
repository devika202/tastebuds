FactoryBot.define do
    factory :user do
      firstname { "Devika" }
      lastname { "S" }
      username { "devika@1" }
      password { "123456789" }
      password_confirmation { "123456789" }
      address { "Kerala, India" }
      phone { "9633826969" }
      sequence(:email) { |n| "user#{n}@example.com" }
      admin { false }
      trait :with_unique_email do
        sequence(:email) { |n| "user#{n}@example.com" }
      end
    end
    factory :admin_user, class: User do
      firstname { "Admin" }
      lastname { "User" }
      username { "admin" }
      password { "password" }
      password_confirmation { "password" }
      address { "Admin Address" }
      phone { "1234567890" }
      email { "admin@example.com" }
      admin { true }
    end
  end
  
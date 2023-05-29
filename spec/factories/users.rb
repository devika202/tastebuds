FactoryBot.define do
    factory :user do
      firstname { "Devika" }
      lastname { "S" }
      username { "admin@1" }
      password { "administrator" }
      password_confirmation { "administrator" }
      address { "Kerala, India" }
      phone { "9633826969" }
      email { "tastebudsadmin1@gmail.com" }
      admin { false }
    end
  end
  
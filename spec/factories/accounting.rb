FactoryBot.define do
    factory :accounting do
      identifier { 'example_identifier' }
      order_id { nil }
      sales_report_id { 6 }
      created_at { '2023-05-18 05:35:25' }
      updated_at { '2023-05-18 05:35:25' }
      amount { nil }
      source { 'Shop Sale' }
      trait :with_order_id do
        association :order
      end
      trait :invalid do
      end
      trait :with_sales_report_id do
        association :sales_report
      end
  
      trait :with_both_ids do
        association :order
        association :sales_report
      end
    end
  end
  
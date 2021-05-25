FactoryBot.define do
  factory :item do
    name { '名前' }
    description { '説明' }
    category_id { 2 }
    status_id { 2 }
    prefecture_id { 2 }
    fee_status_id { 2 }
    days_to_ship_id { 2 }
    selling_price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

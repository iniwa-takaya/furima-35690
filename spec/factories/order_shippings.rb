FactoryBot.define do
  factory :order_shipping do
    postal_code { "123-4567" }
    prefecture_id { 2 }
    city { "市区町村" }
    address_name { "１1番地" }
    building { "１1建物名" }
    phone_number { Faker::Number.number(digits: 11) }
    token {"tok_abcdefghijk00000000000000000"}
  end
end

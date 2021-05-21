FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { 'a12345' }
    password_confirmation { password }
    nick_name { 'あ' }
    last_name { '亞あア' }
    first_name { '亞あア' }
    last_name_kana { 'ア' }
    first_name_kana { 'ア' }
    birthday { '2000-01-01' }
  end
end

FactoryBot.define do
  factory :user do
    pw = Faker::Internet.password
    email  { Faker::Internet.email }
    password { pw }
    password_confirmation { pw }
    api_key { Faker::Internet.uuid }
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checkin do
    body "MyText"
    restaurant_id 1
    user_id 1
  end
end

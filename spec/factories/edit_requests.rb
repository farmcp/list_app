# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :edit_request do
    restaurant nil
    user nil
    approved false
    params "MyText"
  end
end

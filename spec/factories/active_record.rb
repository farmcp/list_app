FactoryGirl.define do
  factory :user do
    email                 { FactoryGirl.generate(:email) }
    password              { 'abcdef' }
    password_confirmation { 'abcdef' }
  end

  factory :relationship do
    follower { FactoryGirl.create(:user) }
    followed { FactoryGirl.create(:user) }
  end
end

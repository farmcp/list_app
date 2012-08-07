FactoryGirl.define do
  factory :city do
    name         { FactoryGirl.generate(:name) }
    abbreviation { FactoryGirl.generate(:name)[0,2] }
    state        { 'CA' }
    active       { true }
  end

  factory :restaurant do
    name         { 'TapFood' }
    phone_number { '9253991023' }
    category     { 'food' }
    address      { '111 Sutter St.' }
    postal_code  { '94104' }
    city         { FactoryGirl.create(:city) }
    active       { true }
    latitude     { FactoryGirl.generate(:latitude) }
    longitude    { FactoryGirl.generate(:longitude) }
    gmaps        { true }
    yelp_url     { FactoryGirl.generate(:udid) }
  end

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

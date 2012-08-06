require './spec/spec_helper'

describe Restaurant do
  before :each do
    @restaurant = FactoryGirl.create(:restaurant)
  end
  it { should validate_uniqueness_of(:yelp_url) }
end

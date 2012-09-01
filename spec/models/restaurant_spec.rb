# == Schema Information
#
# Table name: restaurants
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  picture_url  :string(255)
#  phone_number :string(255)
#  category     :string(255)
#  address      :string(255)
#  postal_code  :string(255)
#  comments     :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  city_id      :integer
#  active       :boolean
#  latitude     :float
#  longitude    :float
#  gmaps        :boolean
#  yelp_url     :string(255)
#

require './spec/spec_helper'

describe Restaurant do
  before :each do
    @restaurant = FactoryGirl.create(:restaurant)
  end

  it { should validate_uniqueness_of(:yelp_url) }
end

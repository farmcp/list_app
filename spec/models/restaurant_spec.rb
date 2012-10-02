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
#  fb_place_id  :string(255)
#

require './spec/spec_helper'

describe Restaurant do
  before :each do
    @restaurant = FactoryGirl.create(:restaurant)
  end

  describe '.acceptable_fb_place' do
    before :each do
      @fb_place = mock()
    end

    it 'should take restaurants' do
      @fb_place.stub(:category).and_return('library, restaurant, lunch')
      Restaurant.acceptable_fb_place?(@fb_place).should be_true
    end

    it 'shouldn\'t accept non-restaurants' do
      @fb_place.stub(:category).and_return('liberry')
      Restaurant.acceptable_fb_place?(@fb_place).should be_false
    end
  end
end

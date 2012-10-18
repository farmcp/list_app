require './spec/spec_helper'

describe City do
  before :each do
    @city = FactoryGirl.create(:city)
  end

  describe '.acceptable_fb_place' do
    before :each do
      @fb_place = mock()
      location = mock()
      location.stub(:city).and_return(@city.name)
      @fb_place.stub(:location).and_return(location)
    end

    it 'should take restaurants' do
      @fb_place.stub(:category).and_return('library, city, lunch')
      @city.acceptable_fb_place?(@fb_place).should be_true
    end

    it 'shouldn\'t accept non-restaurants' do
      @fb_place.stub(:category).and_return('liberry')
      @city.acceptable_fb_place?(@fb_place).should be_false
    end
  end
end

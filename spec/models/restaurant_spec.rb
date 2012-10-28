require './spec/spec_helper'

describe Restaurant do
  before :each do
    @restaurant = FactoryGirl.create(:restaurant)
  end

  describe '#fix_phone_number' do
    before :each do
      @restaurant.phone_number = '920-391-3028'
    end

    it 'discards non-numbers from phone number' do
      @restaurant.fix_phone_number
      @restaurant.phone_number.should == '9203913028'
    end

    context 'phone number has a 1 at the beginning' do
      before :each do
        @restaurant.phone_number = '1-920-391-3028'
      end

      it 'discards leading 1' do
        @restaurant.fix_phone_number
        @restaurant.phone_number.should == '9203913028'
      end
    end
  end
end

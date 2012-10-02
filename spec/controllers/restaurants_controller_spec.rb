require './spec/spec_helper'

describe RestaurantsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @controller.stub(:current_user).and_return(@user)
  end

  describe '#search' do
    before :each do
      @params = { :format => 'json' }
    end

    context 'without query' do
      it 'should return nothing' do
        get :search, @params
        response.body.should == '[]'
      end
    end
  end
end

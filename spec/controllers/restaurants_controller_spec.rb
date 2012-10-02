require './spec/spec_helper'

describe RestaurantsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @controller.stub(:current_user).and_return(@user)
  end

  describe '#search' do
    before :each do
      @params = { :format => 'json' }

      place = mock()
      place.stub('identifier').and_return('1')
      place.stub('name').and_return('some name')

      FbGraph::Place.stub(:search).and_return([place])
    end

    context 'without query' do
      it 'should return nothing' do
        get :search, @params
        response.body.should == '[]'
      end
    end

    context 'with query' do
      it 'should return something' do
        get :search, @params
        response.body.should == '[]'
      end
    end
  end
end

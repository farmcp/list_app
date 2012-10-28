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

  describe '#add_to_list' do
    before :each do
      @restaurant = FactoryGirl.create(:restaurant)
      @params = {id: @restaurant.id}
    end

    context 'user has a list in the city' do
      before :each do
        @list = FactoryGirl.create(:list, user_id: @user.id, city_id: @restaurant.city_id)
      end

      it 'adds to correct list' do
        post :add_to_list, @params
        @user.list_items.find_by_restaurant_id(@restaurant.id).list.city_id.should == @restaurant.city_id
      end
    end

    context 'user has not created a list for the city' do
      it 'creates and adds to list' do
        post :add_to_list, @params
        @user.list_items.find_by_restaurant_id(@restaurant.id).list.city_id.should == @restaurant.city_id
      end
    end
  end
end

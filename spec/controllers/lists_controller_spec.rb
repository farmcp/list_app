require './spec/spec_helper'

describe ListsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @controller.stub(:current_user).and_return(@user)
  end

  describe '#create' do
    before :each do
      @params = {list: {city_id: FactoryGirl.create(:city).id}}
    end

    it 'creates and shows it' do
      post :create, @params
      response.should redirect_to(@user.lists.first)
    end

    context 'when a user is not signed in' do
      before :each do
        @controller.stub(:current_user).and_return(nil)
      end

      it 'redirects to login' do
        post :create, @params
        response.should redirect_to signin_path
      end
    end

    # TODO this should be a model test now
    context 'when current_user has a list with this city' do
      before :each do
        FactoryGirl.create(:list, :city_id => @params[:list][:city_id], :user_id => @user.id)
      end

      it 'fails' do
        false_creation = stub('create', :save => false)
        stub_lists = stub('lists', :find_by_city_id => nil, :create => false_creation)
        @user.stub(:lists).and_return(stub_lists)
        post :create, @params
        response.should render_template(:new)
      end
    end
  end
end

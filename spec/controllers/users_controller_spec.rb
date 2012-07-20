require './spec/spec_helper'

describe UsersController do
  before :each do
    @user = FactoryGirl.create(:user)
    @friends = [
      FactoryGirl.create(:user, :first_name => "Alice"),
      FactoryGirl.create(:user, :first_name => "Bob"),
      FactoryGirl.create(:user, :first_name => "Chris"),
    ]
    FactoryGirl.create(:relationship, :followed => @user, :follower => @friends[0])
    FactoryGirl.create(:relationship, :followed => @user, :follower => @friends[1])
    FactoryGirl.create(:relationship, :followed => @friends[2], :follower => @user)
    @controller.stub(:current_user).and_return(@user)
  end

  describe '#syncable_users' do
    before :each do
      @params = { :format => 'json' }
    end

    context 'without query' do
      it 'should return nothing' do
        get :syncable_users, @params
        response.body.should == '[]'
      end
    end

    context 'with good query' do
      before :each do
        @params[:q] = 'chr'
      end

      it 'should search usrs' do
        get :syncable_users, @params
        response.body.should == @friends[2,1].to_json(:only => [:id], :methods => [:full_name])
      end
    end

    context 'with bad query' do
      before :each do
        @params[:q] = 'dav'
      end

      it 'should search usrs' do
        get :syncable_users, @params
        response.body.should == '[]'
      end
    end
  end
end

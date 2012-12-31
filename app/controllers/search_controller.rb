class SearchController < ApplicationController
  before_filter :signed_in_user

  def search
    #TO DO - make own view for search
    if params[:search] != ''
      users = User.text_search(params[:search])
      restaurants = Restaurant.text_search(params[:search])
      @results_user_count = users.count
      @results_restaurant_count = restaurants.count
      @results = users + restaurants
    end

    respond_to do |format|
      format.html { params[:search] != '' ? render('users/index') : redirect_to(users_path) }
      format.json { render :json => {
        :users => users.to_json(:only => [:id, :first_name, :last_name, :email]), 
        :restaurants => restaurants.to_json(:except => [:fb_place_id, :picture_url])
        } if users or restaurants
      }
    end
  end
end

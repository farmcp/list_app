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
      render 'users/index'
    elsif params[:search] = ''
      redirect_to users_path
    end
  end
end

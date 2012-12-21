class SearchController < ApplicationController
  before_filter :signed_in_user

  def search
    if params[:search] != ''
      users = User.text_search(params[:search])
      restaurants = Restaurant.text_search(params[:search])
      @results_user_count = users.count
      @results_restaurant_count = restaurants.count
      @results = users + restaurants
    elsif params[:search] = ''
      @results = User.all
      @results_user_count = User.all.count
      @results_restaurant_count = 0
    end
    # TODO get its own view
    render 'users/index'
  end
end

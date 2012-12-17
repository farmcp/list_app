class SearchController < ApplicationController
  before_filter :signed_in_user

  def search
    users = User.text_search(params[:search])
    restaurants = Restaurant.text_search(params[:search])
    @results_user_count = users.count
    @results_restaurant_count = restaurants.count
    @results = users + restaurants

    # TODO get its own view
    render 'users/index'
  end
end

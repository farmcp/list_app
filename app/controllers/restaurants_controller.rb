class RestaurantsController < ApplicationController

  #GET page for creating a new restaurant
  def new
    @restaurant = Restaurant.new
  end

  #need to show the restaurant details and comments
  def show
    @restaurant = Restaurant.find(params[:id])
    @maps_json = @restaurant.to_gmaps4rails

    #get comments for the current restaurant - only show the followers' and followed users' comments
    if current_user 
      friends = current_user.followers | current_user.followed_users
      friends << current_user
      @comments = []
      friends.each do |friend|
        @comments << friend.comments.where('restaurant_id = '.concat(params[:id].to_s))
      end
      @comments = @comments.flatten
    else
      @comments = []
    end
  end

  #POST action for creating a new restaurant
  def create

    #TODO: Need to check if the Restaurant exists already.
    @restaurant = Restaurant.new(params[:restaurant])
    city_input = City.find(params[:city][:name])

    #save the city_id for the restaurant
    @restaurant.city_id = city_input.id
    if @restaurant.save

      #saved the restaurant
      flash[:success] = "Thank you! You've successfully submitted a restaurant to Bite List!"
      redirect_to new_restaurant_path
    else
      render 'new'
    end
  end
end

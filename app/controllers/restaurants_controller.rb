class RestaurantsController < ApplicationController

  #GET page for creating a new restaurant
  def new
    @restaurant = Restaurant.new
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

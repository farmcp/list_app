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
      friends_ids = current_user.followers.map(&:id) | current_user.followed_users.map(&:id) | [current_user.id]
      @comments = Comment.where(:restaurant_id => params[:id], :user_id => friends_ids.uniq).flatten
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

  def search
    if params[:q]
      query = params[:q].to_s.strip
      json = Restaurant.in(params[:city_id]).search(query).to_json(:only => [:id, :name])
    else
      json = '[]'
    end

    respond_to do |format|
      format.json { render :json => json }
    end
  end
end

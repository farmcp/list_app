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
    @restaurant = Restaurant.new(params[:restaurant])
    city_input = City.find(params[:city][:name])
    @restaurant.city_id = city_input.id
    if @restaurant.save
      flash[:success] = "Thank you! You've successfully submitted a restaurant to Bitelist!"
      redirect_to new_restaurant_path
    else
      render 'new'
    end
  end

  #loopj hits this controller automatically and tacks on a param "q"
  #TO DO: need to add ability to search current database from places that are added internally
  def search
    query = params[:q].to_s.strip
    if query.present?
      current_city = City.includes(:sub_cities).find(params[:city_id])
      fb_results = FbGraph::Place.search(
        query,
        :center => current_city.fb_center,
        :access_token => current_user.remember_token
      ).select{|place| current_city.acceptable_fb_place?(place)}

      json = fb_results.map{|place| {id: place.identifier, name: place.name}}.to_json
    else
      json = '[]'
    end

    respond_to do |format|
      format.json { render :json => json }
    end
  end
end

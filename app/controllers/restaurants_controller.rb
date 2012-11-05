class RestaurantsController < ApplicationController
  before_filter :signed_in_user, :only => [:add_to_list]
  before_filter :require_restaurant, only: [:show, :add_to_list]

  #GET page for creating a new restaurant
  def new
    @restaurant = Restaurant.new
  end

  #GET page to edit restaurants
  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  #PUT for updating the restaurant
  def update
  end

  #need to show the restaurant details and comments
  def show
    @maps_json = @restaurant.to_gmaps4rails
    @location_string = [@restaurant.address, @restaurant.city_state_zip].join(' ')
    #get comments for the current restaurant - only show the followers' and followed users' comments
    if current_user
      friends_ids = current_user.followers.map(&:id) | current_user.followed_users.map(&:id) | [current_user.id]
      @comments = Comment.where(:restaurant_id => params[:id], :user_id => friends_ids.uniq).flatten

      #get followed users that have this restaurant
      @followed_users = current_user.followed_users.select{|user| user.restaurants.include?Restaurant.find(params[:id])}
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
    # [issue #41] replace possessive apostroph-s with just s; e.g. "Bear's Ramen House"
    query = params[:q].to_s.strip.gsub(/'s\b/, "s")
    if query.present?
      current_city = City.includes(:sub_cities).find(params[:city_id])
      fb_search_options = {
        center: current_city.fb_center,
        access_token: current_user.fb_search_token
      }
      results = FbGraph::Place.search(query, fb_search_options).map do |place|
        if current_city.acceptable_fb_place?(place)
          {id: place.identifier, name: place.name}
        end
      end.compact
    else
      results = []
    end

    render :json => results.to_json
  end

  # handle post directly from restaurant to add to list
  def add_to_list
    list = current_user.list_for(@restaurant)
    list.list_item_for(@restaurant)

    redirect_to list
  end

  private

  def require_restaurant
    @restaurant = Restaurant.find(params[:id]) or render status: 404
  end
end

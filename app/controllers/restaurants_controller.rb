class RestaurantsController < ApplicationController
  before_filter :signed_in_user, :only => [:add_to_list]
  before_filter :require_restaurant, only: [:show, :edit, :add_to_list]

  #GET page for creating a new restaurant
  def new
    @restaurant = Restaurant.new
  end

  #need to show the restaurant details and comments
  def show
    @maps_json = @restaurant.to_gmaps4rails
    #get comments for the current restaurant - only show the followers' and followed users' comments
    if current_user
      friends_ids = current_user.followers.map(&:id) | current_user.followed_users.map(&:id) | [current_user.id]
      @comments = Comment.where(:restaurant_id => params[:id], :user_id => friends_ids.uniq).flatten

      #get followed users that have this restaurant
      @followed_users = current_user.followed_users.select{|user| user.restaurants.include?Restaurant.find(params[:id])}

      if FbGraph::User.me(current_user.remember_token).permissions.include?(:publish_checkins)
        @fb_checkin = true
        #if the current user checked in within 10 min, don't allow them to check in
        if current_user.checkins.count > 0
          if Time.now - current_user.checkins.order("created_at").last.created_at > 600
            @allow_checkin = true
          else
            @allow_checkin = false
          end
        else
          @allow_checkin = true
        end
      end
    else
      @comments = []
    end
  end

  def edit
    @edit_request = EditRequest.new
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
        if current_city.acceptable_fb_place?(place) && place.location.street != "" && place.location.city != ""
          {id: place.identifier, name: place.name, address: place.location.street, city: place.location.city, url: place.fetch.picture}
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

  #POST checkin to facebook
  def post_to_facebook
    restaurant = Restaurant.find(params[:id])

    place = FbGraph::Place.fetch(restaurant.fb_place_id)
    FbGraph::User.me(current_user.remember_token).checkin!(:coordinates => place.location, :place => place)

    #no body for now
    Checkin.create(:restaurant_id => restaurant.id, :user_id => current_user.id)

    flash[:info] = "You have checked in on Facebook!"

    redirect_to restaurant
  end

  private

  def require_restaurant
    @restaurant = Restaurant.find(params[:id]) or render status: 404
  end
end

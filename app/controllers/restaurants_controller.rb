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
    yelp_url = params[:restaurant][:yelp_url]
    @restaurant = Restaurant.where(:yelp_url => yelp_url).first
    @restaurant ||= Yelp.parse(yelp_url)
    if @restaurant.save
      flash[:success] = "Thank you! You've successfully submitted a restaurant to Bitelist!"
      redirect_to new_restaurant_path
    else
      render 'new'
    end
  end

  def search
    if params[:q]
      query = params[:q].to_s.strip

      #search bitelist database for restaurant
      json = Restaurant.in(params[:city_id]).search(query).to_json(:only => [:id, :name])

      #if it doesn't exist in database then search facebook for the restaurant then add some of the information to database
      if !json.any?
        current_city = City.find(params[:city_id])
        json = FbGraph::Place.search(
          query.to_s,
          :center => current_city.longitude.to_s + ', ' + current_city.latitude.to_s,
          :access_token => current_user.remember_token
          )
      end

    else
      json = '[]'
    end

    respond_to do |format|
      format.json { render :json => json }
    end
  end
end

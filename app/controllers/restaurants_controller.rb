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
#      results = Restaurant.in(params[:city_id]).search(query)

      #if it doesn't exist in database then search facebook for the restaurant then add some of the information to database - what about the overlaps 
      #if you search for 'Lonuge' there are some in bitelist database and some that are not
      current_city = City.find(params[:city_id])
      center = current_city.latitude.to_s + ', ' + current_city.longitude.to_s
      token = current_user.remember_token

      places = FbGraph::Place.search(
        query.to_s,
        :center => center,
        :access_token => token
      )
      results = Array.new
      places.each do |place|
        if place.category.downcase.include?'restaurant' or place.category.include?'cafe' or place.category.include?'breakfast' or place.category.include?'lunch' or place.category.include?'dinner'
          results << place
        end
      end

      results.each do |result|
        unless Restaurant.find_by_fb_place_id(result.identifier)
          fetched_result = result.fetch
          restaurant = Restaurant.new(
            :name => fetched_result.name, 
            :picture_url => fetched_result.picture,
            :phone_number => fetched_result.phone,
            :category => fetched_result.category,
            :address => fetched_result.location.street,
            :postal_code => fetched_result.location.zip,
            :city_id => current_city.id,
            :active => true,
            :fb_place_id => fetched_result.identifier.to_s,
            :latitude => fetched_result.location.latitude,
            :longitude => fetched_result.location.longitude
          )
          restaurant.save!
        end
      end

      #convert to json for json response - return the facebook ID 
      json = Restaurant.in(params[:city_id]).search(query).to_json(:only => [:id, :name])

    else
      json = '[]'
    end

    respond_to do |format|
      format.json { render :json => json }
    end
  end
end

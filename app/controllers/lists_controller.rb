class ListsController < ApplicationController
  before_filter :signed_in_user, :only => [:new, :create, :destroy]
  before_filter :correct_user, :only => :destroy

  #GET request for displaying how to create a new List
  def new
    @list = List.new
    @sfo = City.find_by_name 'San Francisco'
    @bos = City.find_by_name 'Boston'

    #TO DO: Need to add other cities => New York, Chicago, Hawaii, Los Angeles
  end

  #POST request for creating a new List
  def create
    # create a list for the current user if (s)he doesn't have a list already for the specific name and is signed in
    city = City.find(params[:list][:city_id])
    if signed_in? && current_user.lists.map(&:city).include?(city)
      @list = current_user.lists.create(params[:list])
      if @list.save
        #if you can save the list then you say success and redirect back to the user
        flash[:success] = "Bitelist created for " + city.name.to_s + "! Start adding restaurants!"
        redirect_to @list
      else
        render 'new'
      end
    else
      #need to get flash to show why you can't upload a new list => mainly because you already have a list with the city
      flash[:error] = "Can't create more than one Bitelist for each city."
      redirect_to current_user
    end
  end

  #DELETE request for killing a list => located on the user/:id page for showing a user
  def destroy
    @list.destroy
    redirect_to :back
  end

  #GET request to show lists/:id
  def show
    # get the list from the id that's passed in
    @list = List.find_by_id(params[:id])
    if @list
      @restaurants = @list.restaurants

      # get the json for the maps
      @maps_json = @restaurants.to_gmaps4rails

      # pass in a variable to create a new List Item if the user enters a name into the text_field
      @list_item = ListItem.new
    else
      # else if there is no list, then redirect to root
      flash[:error] = "There was a problem finding your list."
      redirect_to new_session_path
    end
  end

  # TODO: maybe this should be json?
  def add_to
    list = current_user.lists.find(params[:restaurant][:list_id])
    count = list.list_items.count
    fb_ids = params[:restaurant][:name].split(',')
    restaurants = Hash[fb_ids.zip([])]
    list_restaurants = {}

    list.city.restaurants.where(:fb_place_id => fb_ids).each do |restaurant|
      restaurants[restaurant.fb_place_id] = restaurant
    end

    list.restaurants.each do |restaurant|
      list_restaurants[restaurant.id] = restaurant
    end

    restaurants.each do |fb_id, restaurant|
      if restaurant.nil?
        restaurant = Restaurant.create_from_facebook(fb_id, list.city_id)
      elsif list_restaurants[restaurant.id].present?
        next
      end

      if count >= List::MAX_ITEMS_PER_LIST
        flash[:error] = "You can only have #{List::MAX_ITEMS_PER_LIST} restaurants per list!"
        break
      end
      list.list_items.create!(:restaurant_id => restaurant.id)
      count += 1
    end

    redirect_to :back
  end

  private

  def correct_user
    @list = current_user.lists.find_by_id(params[:id])
    redirect_to new_session_path if @list.nil?
  end
end

class ListsController < ApplicationController
  before_filter :signed_in_user, :only => [:new, :create, :destroy]
  before_filter :correct_user, :only => :destroy


  #GET request for displaying how to create a new List
  def new
    @list = List.new
    @sfo = City.find_by_name 'San Francisco'
    @bos = City.find_by_name 'Boston'
  end

  #POST request for creating a new List
  def create
    #create a list for the current user if (s)he doesn't have a list already for the specific name and is signed in
    if signed_in? and current_user.lists.exclude?current_user.lists.find_by_city_id(params[:list][:city_id])
      @list = current_user.lists.create(params[:list])
      if @list.save
        #if you can save the list then you say success and redirect back to the user
        flash[:success] = "Bite List created for " + current_user.lists.find_by_city_id(params[:list][:city_id]).city.name.to_s + "!"
        redirect_to current_user
      else
        render 'new'
    end

    else
      #need to get flash to show why you can't upload a new list => mainly because you already have a list with the city
      flash[:error] = "Can't create more than one Bite List for each city."
      redirect_to current_user
    end
  end

  #DELETE request for killing a list => located on the user/:id page for showing a user
  def destroy
    @list.destroy
    redirect_back_or new_session_path
  end

  #GET request to show lists/:id
  def show
    #if the list exists then store a class variable for the list to catch on the view
    if List.find_by_id(params[:id]) and current_user
      #get the list from the id that's passed in
      @list = List.find_by_id(params[:id])

      #go through the list and create array of restaurants
      @restaurants = Array.new
      @list.list_items.each do |item|
        @restaurants << item.restaurant
      end

      #get the json for the maps
      @maps_json = @restaurants.to_gmaps4rails

      #pass in a variable to create a new List Item if the user enters a name into the text_field
      @list_item = ListItem.new
    else
    #else if there is no list, then redirect to root
      flash[:error] = "There was a problem finding your list."
      redirect_to new_session_path
    end
  end

  # TODO: maybe this should be json?
  def add_to
    list = List.find(params[:restaurant][:list_id])
    rest_ids = params[:restaurant][:name]
    restaurants = Restaurant.where(:city_id => list.city_id, :id => rest_ids)
    restaurants.each do |restaurant|
      item = list.list_items.build(:restaurant_id => restaurant.id)
      item.save!
    end
    redirect_to :back
  end

  private

  def correct_user
    @list = current_user.lists.find_by_id(params[:id])
    redirect_to new_session_path if @list.nil?
  end
end

class ListsController < ApplicationController
  before_filter :signed_in_user, :only => [:new, :create, :destroy]
  before_filter :correct_user, :only => :destroy


  #GET request for displaying how to create a new List
  def new
    @list = List.new
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
    redirect_back_or root_path
  end

  def show
    @list = List.find_by_id(params[:id])
  end

  private

  def correct_user
    @list = current_user.lists.find_by_id(params[:id])
    redirect_to root_path if @list.nil?
  end
end

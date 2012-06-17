class ListsController < ApplicationController
  before_filter :signed_in_user, :only => [:new, :create, :destroy]
  before_filter :correct_user, :only => :destroy

  def new
    @list = List.new
  end

  def create
    #create a list for the current user if (s)he doesn't have a list already for the specific name and is signed in
    if signed_in? and current_user.lists.exclude?current_user.lists.find_by_city_id(params[:list][:city_id])
      @list = current_user.lists.create(params[:list])
      if @list.save
        flash.now[:success] = "Bite List Created!"
        redirect_to root_path
      else
        render 'new'
    end

    else
      #need to get flash to show why
      flash.now[:error] = "Please enter a list that doesn't exist."
      redirect_to root_path
    end
  end

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

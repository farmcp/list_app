class UsersController < ApplicationController

  #calls this before any of the other defined actions (here just :edit and :update) in this controller
  before_filter :signed_in_user, only: [:edit, :update, :show, :index, :destroy]

  #make sure the correct user is signed in to edit the profile - users can see each other's pages
  before_filter :correct_user, only:[:edit, :update]

  #GET /users/new => this is the GET page to start creating another User
  def new
    @user = User.new
  end

  #POST /users
  def create
    #if the user passes all the validation - save the user to the database
    @user = User.new(params[:user])
    if @user.save
      #send a flash hash to view to alert the user they have signed in successfully
      flash[:success] = "You have successfully logged in " + @user.first_name.to_s + "!"

      #sign the user in by dropping a cookie 
      sign_in @user

      #Handle a successful save
      #redirect to the users/show/:id page 
      redirect_to @user
    else
      #if not a successful save then go back to the new page
      render 'new'
    end
  end

  #GET /users/:id => this is the GET page to show a user with :id
  def show
    @user = User.find(params[:id])
  end

  #GET /users/:id/edit => this is the GET page to show a user with :id the edit page the submission will be a PUT request
  #redirecting the user to update method in controller
  def edit 
  end

  #update the user's profile using this method => it is PUT request to the server on the submission of the form
  def update
    if @user.update_attributes(params[:user])
      #if you can update a user then handle the update for the user
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      #unsuccessful update
      render 'edit'
    end
  end

  #GET request for /users/
  def index
    #use the will_paginate gem .paginate method => .paginate(page_number) returns numbers 1-30, 31-60, etc. params[:page] is 
    #generated automatically by will_paginate
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User has been removed."
    redirect_to users_path
  end


####################################
#private methods for users
####################################
  private

  def signed_in_user
    unless signed_in?
      #store the location
      store_location

      flash[:notice] = "Please sign in."
      redirect_to signin_path
    end
  end

  def correct_user

    #define the user for the :edit and :update methods
    @user = User.find(params[:id])

    #unless the user is the current user then redirect to the root path
    if current_user?(@user)

    else
      flash[:notice] = "You do not have access to this page."
      redirect_to root_path
    end

  end
end

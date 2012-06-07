class UsersController < ApplicationController

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
  	@user = User.find_by_id(params[:id])
  end
end

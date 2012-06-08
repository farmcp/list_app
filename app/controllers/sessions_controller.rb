class SessionsController < ApplicationController
	#GET the page that will create a new session
	def new

	end

	#POST the information that will create the new session and drop teh cookie
	def create
		#if the email and password exist in the database then drop a cookie
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else 
			flash.now[:error] = "Invalid Username or Password combination"
			render 'new'
		end

	end

	#DELETE the cookie and kill the session
	def destroy
		sign_out
		redirect_to root_path
	end
end

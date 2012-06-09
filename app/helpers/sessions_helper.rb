module SessionsHelper

	#sign the user in by placing a cookie with the remember token for that person generated by user model then assign current user
	def sign_in user
		cookies.permanent[:remember_token] = user.remember_token
		current_user = user
	end

	def signed_in?
		#is a user signed in? return true if the current_user is not nil
		!current_user.nil?
	end

	#sign the user out
	def sign_out
		#kill the cookie
		current_user = nil
		cookies.delete(:remember_token)
	end


	#need a setter method for current_user defined in sign_in - reason is the current user can change and need to be
	#ready to redefice the current user
	def current_user=(user)
		#make current user accessible to views
		@current_user = user
	end

	#getter method that doesn't sign user out
	def current_user
		#if there is a current user use them. if not then use the user from the remember token
		@current_user ||= user_from_remember_token
	end

	def current_user?(user)
		user == current_user
	end

####################################################
#Friendly Forwarding
#use session to store cookies :return_to and the path where you're trying to go
###################################################
	def store_location
		session[:return_to] = request.fullpath
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end


	private 

		def user_from_remember_token
			remember_token = cookies[:remember_token]

			#return the user that has the remember token unless the remember token is not available
			User.find_by_remember_token(remember_token) unless remember_token.nil?
		end

		def clear_return_to
			session.delete(:return_to)
		end


end

class ListsController < ApplicationController
	before_filter :signed_in_user, :only => [:new, :create, :destroy]
	before_filter :correct_user, :only => :destroy


	def new
		@list = List.new
	end

	def create
		#create a list for the current user
		@list = current_user.lists.create(params[:list]) if signed_in?
		if @list.save
			flash[:success] = "Bite List Created!"
			redirect_to root_path
		else
			render 'new'
		end
	end 

	def destroy
		@list.destroy
		redirect_back_or root_path
	end

	private
	def correct_user
		@list = current_user.lists.find_by_id(params[:id])
		redirect_to root_path if @list.nil?
	end

end
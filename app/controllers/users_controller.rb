require 'will_paginate/array'

class UsersController < ApplicationController

  #calls this before any of the other defined actions (here just :edit and :update) in this controller
  before_filter :signed_in_user, only: [:edit, :update, :show, :index, :destroy, :syncable_users]

  #make sure the correct user is signed in to edit the profile - users can see each other's pages
  before_filter :correct_user, only:[:edit, :update]

  def new
    @user = User.new
  end

  def create
    params[:user][:password_confirmation] = params[:user][:password]
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "You have successfully logged in " + @user.first_name.to_s + "!"

      # TODO: this should be handled via queue
      UserMailer.welcome_email(@user).deliver

      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_lists = @user.lists.paginate(page: params[:page])
    @user_feed = User.create_feed([@user])

    feed_users = [current_user.followed_users, current_user].flatten
    @lists = current_user.lists.paginate(page: params[:page])
    @feed= User.create_feed(feed_users)
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      #if you can update a user then handle the update for the user
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.search(params[:search]).paginate
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User has been removed."
    redirect_to users_path
  end

  #return all followeds
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    if params[:q]
      @followeds = @user.followed_users.search(params[:q])
    end

    respond_to do |format|
      format.html {render 'show_follow'}
      format.json {render :json => @followeds.to_json(:only => [:id], :methods => [:full_name])}
    end

  end

  #return all followers
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    if params[:q]
      @followers = @user.followers.search(params[:q])
    end

    respond_to do |format|
      format.html {render 'show_follow'}
      format.json {render :json => @followers.to_json(:only => [:id], :methods => [:full_name])}
    end
  end

  def syncable_users
    if params[:q]
      # TODO can do this in a single query with arel magic
      friends = current_user.followers.search(params[:q]) | current_user.followed_users.search(params[:q])
      json = friends.to_json(:only => [:id], :methods => [:full_name])
    else
      json = '[]'
    end

    respond_to do |format|
      format.json { render :json => json }
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])

    unless current_user?(@user)
      flash[:notice] = "You do not have access to this page."
      redirect_to new_session_path
    end
  end
end

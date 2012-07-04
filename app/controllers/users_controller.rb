require 'will_paginate/array'

class UsersController < ApplicationController

  #calls this before any of the other defined actions (here just :edit and :update) in this controller
  before_filter :signed_in_user, only: [:edit, :update, :show, :index, :destroy]

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
    @lists = @user.lists.paginate(page: params[:page])
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
    if params[:search]
      @users = User.find(:all, conditions: ['lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{params[:search].downcase}%", "%#{params[:search].downcase}%"]).paginate(page: params[:page], per_page: 10)
    else
      @users = User.paginate(page: params[:page], per_page:10)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User has been removed."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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

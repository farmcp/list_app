require 'will_paginate/array'
class UsersController < ApplicationController
  #calls this before any of the other defined actions (here just :edit and :update) in this controller
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]

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
    @lists = @user.lists
    @user_feed = Story.includes([:list, :list_item, :comment]).where(:user_id => @user.id).order('created_at desc').paginate(:page => params[:page])

    #get all restaurants around you from people you follow and your own restaurants
    @friends = @user.followed_users
    current_user_restos = current_user.restaurants

    @maps_json = (@friends.collect{|f| f.restaurants} + current_user_restos).flatten.to_gmaps4rails
    @user_image = @user.avatar_url
    #if the user is a facebook user - get a list of their friends who is on facebook and also on bitelist
    @non_followed_fb_users = []
    if @user.fb_id && @user.remember_token
      # TODO: fix this
      begin
        fb_user = FbGraph::User.me(current_user.remember_token)
        #friends that are on bitelist minus the users that you follow
        fb_user_friends = fb_user.friends.map{|u| u.raw_attributes['id']} & User.all.map{|u| u.fb_id}
        fb_followed_users = @user.followed_users.map{|u| u.fb_id}.compact.to_a
        #randomly select 3 users that are your friends from facebook that you haven't followed on bitelist
        @non_followed_fb_users = (fb_user_friends - fb_followed_users).collect!{|id| User.find_by_fb_id(id)}.shuffle.first(3)
      rescue
        # shit is breaking
      end
    end

    if current_user? @user
      feed_users = [current_user.followed_users, current_user].flatten
      @my_feed = Story.includes_all.where(:user_id => feed_users.map(&:id)).order('created_at desc').paginate(:page => params[:page])
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      #if you can update a user then handle the update for the user
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @results = User.order('first_name, last_name')
    @results_user_count = @results.count
    @results_restaurant_count = 0
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

  def fb_friends
    if current_user.provider == 'facebook'
      me = FbGraph::User.me(current_user.remember_token)
      @friends = me.friends
    else
      @friends = []
    end
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # POST method to invite by email
  def invite_by_email
    if params[:email] =~ VALID_EMAIL_REGEX
      new_user_email = params[:email]
      current_user.send_invite_to_new_user(new_user_email)
      flash[:success] = 'You have invited your friend!'
    else
      flash[:error] = 'You have entered an invalid email address'
    end

    redirect_to fb_friends_user_path
  end

  private

  def correct_user
    @user = User.find(params[:id])

    unless current_user?(@user)
      flash[:notice] = "You do not have access to this page."
      redirect_to new_session_path
    end
  end

  def user_params
    params[:user].slice(:first_name, :last_name, :password, :password_confirmation)
  end
end

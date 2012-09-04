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
    @lists = @user.lists
    @user_feed = Story.includes([:list, :list_item, :comment]).where(:user_id => @user.id).order('created_at desc').paginate(:page => params[:page])


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

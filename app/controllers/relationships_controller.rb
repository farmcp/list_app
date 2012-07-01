class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    flash[:success] = "You're following #{@user.first_name} #{@user.last_name}!"
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    flash[:error] = "You don't follow #{@user.first_name} #{@user.last_name} anymore."
    redirect_to @user
  end
end

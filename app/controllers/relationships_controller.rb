class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html {
        flash[:success] = "You're following #{@user.full_name}!"
        redirect_to current_user
      }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html {
        flash[:error] = "You've stopped following #{@user.full_name}."
        redirect_to current_user
      }
      format.js
    end
  end
end

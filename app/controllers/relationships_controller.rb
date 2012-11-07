class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
# take this out because of ajax    flash[:success] = "You're following #{@user.full_name}!"
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
# take thish out because of ajax    flash[:error] = "You've stopped following #{@user.full_name}."
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end

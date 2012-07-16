class SyncController < ApplicationController
  def show
    @followeds = current_user.followed_users
    @followers = current_user.followers
  end
end
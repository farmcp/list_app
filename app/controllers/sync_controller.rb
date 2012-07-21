class SyncController < ApplicationController
  def show
  end

  #get recommendations for the useres that are returned from the input
  def get_sync
    #TODO: run algorithms with the params passed in
    @passed_ids = params[:ids].split(',')
    @users = @passed_ids.collect{|id| User.find(id)}

    #add the current user to the list
    @users << current_user
    @recommendations = @users
    respond_to do |format|
      format.json {render :json => @recommendations.to_json}
    end
  end
end
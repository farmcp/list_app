include SyncHelper

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

    #run the algorithm to get the recommendations (algorithm main starts in the helper)
    @recommendations = get_recommendations(@users)

    #create a map for where these recommendations are
    @maps_json = @recommendations.to_gmaps4rails

    #different formats to return json
    respond_to do |format|
      format.html {render 'get_sync'}
      format.json {render :json => @recommendations.to_json}
    end
  end
end
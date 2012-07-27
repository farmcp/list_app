module SyncHelper
  #create a recommendations engine here - right now just returns all of the users that were inputted and their restaurants
  def get_recommendations(users, location=nil)
    #simple algorithm is to show the most popular places at the top and if there are ties then show the closest ones?
    restaurants = users.collect(&:list_items).flatten.collect(&:restaurant)
    # histogram returns { restaurant => frequency }
    restaurants.sort_by_frequency
  end
end

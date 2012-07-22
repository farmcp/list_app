module SyncHelper
  #create a recommendations engine here - right now just returns all of the users that were inputted and their restaurants
  def get_recommendations(users, location=nil)
    list_items = users.collect(&:list_items).flatten
    @recommendations = list_items.collect(&:restaurant).flatten

    #return a list of restaurants
    return @recommendations
  end
end
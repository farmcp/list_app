module SyncHelper
  #create a recommendations engine here - right now just returns all of the users that were inputted and their restaurants
  def get_recommendations(users, location=nil)
    #simple algorithm is to show the most popular places at the top and if there are ties then show the closest ones?
    count_hash = Hash.new(0)
    list_items = users.collect(&:list_items).flatten
    unsorted_rests = list_items.collect(&:restaurant).flatten

    unsorted_rests.each do |rec|
      count_hash[rec] += 1
    end
  
    @restaurants = []
    count_hash.sort_by{|k,v| @restaurants << k }.reverse
  
    puts @restaurants
    puts count_hash
    #return a list of restaurants
    return @restaurants
  end
end
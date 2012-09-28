class ListItemsController < ApplicationController

  def create
    #get the restaurant
    restaurant_name = params[:restaurant][:name]
    input_restaurant = Restaurant.find_by_name(restaurant_name)
    #get the list_id and user itmes
    list_id = params[:restaurant][:list_id]
    user_items = current_user.lists.find(list_id).list_items
    #get the current city
    current_city = List.find(list_id).city

    # if a restaurant exists for a specific city then find it and capture that as a variable.
    # if it doesn't exist then create a new restaurant (Restaurant.create)
    if input_restaurant && input_restaurant.city == current_city && input_restaurant.active?
      #get the ids for the restaurants in the current list => need to check if the id exists in the list
      restaurant_ids = user_items.map(&:restaurant_id)

      if restaurant_ids.include? input_restaurant.id
        flash[:error] = "The restaurant already exists in your Bitelist."
      else
        #used a hidden field to pass in the list_id that this POST request was sent from
        user_items.create(:restaurant_id => input_restaurant.id)
        flash[:success] = "Added #{input_restaurant.name} to your Bitelist!"
      end
    else
      #create a new Restaurant with the name that was entered
      #TODO: need to make a more complete form for filling out new restaurants - need to add validation for restaurants
      flash[:error] = "That restaurant is not in the database."
    end

    #redirect_to list
    redirect_to list_path(list_id)
  end

  def destroy
    #flash the user it's been deleted
    flash[:success] = "You've removed #{ListItem.find(params[:id]).restaurant.name} from your Bitelist!"

    #delete the item that's passed in
    ListItem.find(params[:id]).destroy

    #After the ListItem has been deleted go back to the original page
    redirect_to :back
  end
end

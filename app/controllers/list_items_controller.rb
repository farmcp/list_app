class ListItemsController < ApplicationController

  def create
    restaurant_name = params[:restaurant][:name]
    input_restaurant = Restaurant.find_by_name(restaurant_name)
    list_id = params[:restaurant][:list_id]
    user_items = current_user.lists.find(list_id).list_items
    current_city = List.find(list_id).city

    #if a restaurant exists for a specific city then find it and capture that as a variable. if it doesn't exist then create a new restaurant (Restaurant.create)
    if(input_restaurant and current_city.restaurants.all.include?input_restaurant and input_restaurant.active)

      #current_list.list_items.create(:restaurant_id => restaurant_variable.id)
      #used a hidden field to pass in the list_id that this POST request was sent from
      user_items.create(:restaurant_id => input_restaurant.id)
      flash[:success] = "Added #{input_restaurant.name} to your Bite List!"

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
    flash[:success] = "You've removed #{ListItem.find(params[:id]).restaurant.name} from your Bite List!"

    #delete the item that's passed in
    ListItem.find(params[:id]).destroy

    #After the ListItem has been deleted go back to the original page
    redirect_to :back
  end
end

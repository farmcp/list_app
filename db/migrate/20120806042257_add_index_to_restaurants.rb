class AddIndexToRestaurants < ActiveRecord::Migration
  def change
    add_index :restaurants, :yelp_url
  end
end

class AddYelpUrlToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :yelp_url, :string
  end
end

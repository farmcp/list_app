class AddYelpUrlToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :yelp_url, :string
    add_index :restaurants, :yelp_url
  end
end

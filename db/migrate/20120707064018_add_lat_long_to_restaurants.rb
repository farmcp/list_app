class AddLatLongToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
    add_column :restaurants, :gmaps, :boolean
  end
end

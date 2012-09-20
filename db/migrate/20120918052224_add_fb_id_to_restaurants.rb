class AddFbIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :fb_place_id, :string
    add_index :restaurants, :fb_place_id
  end
end

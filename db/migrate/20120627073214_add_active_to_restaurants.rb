class AddActiveToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :active, :boolean
    change_column :restaurants, :postal_code, :string
  end
end

class ChangeDataTypeForRestaurantCityId < ActiveRecord::Migration
  def change
    remove_column :restaurants, :city_id
    add_column :restaurants, :city_id, :integer
  end
end

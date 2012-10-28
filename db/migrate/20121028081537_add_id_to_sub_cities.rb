class AddIdToSubCities < ActiveRecord::Migration
  def change
    add_column :sub_cities, :id, :primary_key
  end
end

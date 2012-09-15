class AddLongitudeAndLatitudeToCities < ActiveRecord::Migration
  def change
    add_column :cities, :longitude, :float
    add_column :cities, :latitude, :float
  end
end

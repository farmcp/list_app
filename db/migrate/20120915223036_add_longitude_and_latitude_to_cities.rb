class AddLongitudeAndLatitudeToCities < ActiveRecord::Migration
  def change
    add_column :cities, :longitude, :float
    add_column :cities, :latitude, :float

    add_index :cities, :longitude
    add_index :cities, :latitude
  end
end

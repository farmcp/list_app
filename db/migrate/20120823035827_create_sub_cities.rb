class CreateSubCities < ActiveRecord::Migration
  def change
    create_table :sub_cities, id: false do |t|
      t.string :name
      t.references :city
    end

    add_index :sub_cities, :name
    add_index :sub_cities, :city_id
  end
end

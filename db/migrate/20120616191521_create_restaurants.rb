class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
    	t.string :name
    	t.string :picture_url
    	t.string :phone_number
    	t.string :category
    	t.string :address
    	t.integer :postal_code
    	t.string :comments
    	t.string :city_id
    	
      t.timestamps
    end
  end
end

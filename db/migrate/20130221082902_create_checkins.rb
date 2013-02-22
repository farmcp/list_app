class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.text :body
      t.integer :restaurant_id
      t.integer :user_id

      t.timestamps
    end
    add_index :checkins, :restaurant_id
    add_index :checkins, :user_id
  end
end

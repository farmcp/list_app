class CreateEditRequests < ActiveRecord::Migration
  def change
    create_table :edit_requests do |t|
      t.references :restaurant
      t.references :user
      t.boolean :approved
      t.text :params

      t.timestamps
    end
    add_index :edit_requests, :restaurant_id
    add_index :edit_requests, :user_id
    add_index :edit_requests, :approved
  end
end

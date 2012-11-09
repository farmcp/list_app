class CreateEditRequests < ActiveRecord::Migration
  def change
    create_table :edit_requests do |t|
      t.references :restaurant
      t.references :user
      t.boolean :accepted, default: false
      t.boolean :rejected, default: false
      t.text :params

      t.timestamps
    end
    add_index :edit_requests, :restaurant_id
    add_index :edit_requests, :user_id
    add_index :edit_requests, :accepted
    add_index :edit_requests, :rejected
  end
end

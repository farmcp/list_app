class UseCityIds < ActiveRecord::Migration
  def change
    add_column :lists, :city_id, :integer
    add_index :lists, :city_id
    remove_column :lists, :city
    remove_column :lists, :state
  end
end

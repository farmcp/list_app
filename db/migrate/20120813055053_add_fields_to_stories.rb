class AddFieldsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :restaurant_id, :integer
  end
end

class AddUserIdToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :user_id, :integer
    add_index :list_items, :user_id
  end
end

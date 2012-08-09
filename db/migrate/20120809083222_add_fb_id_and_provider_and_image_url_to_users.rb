class AddFbIdAndProviderAndImageUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_id, :string
    add_column :users, :provider, :string
    add_column :users, :image_url, :string
  end
end

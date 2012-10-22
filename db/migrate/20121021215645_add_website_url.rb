class AddWebsiteUrl < ActiveRecord::Migration
  def up
    add_column :restaurants, :website_url, :string
  end

  def down
  end
end

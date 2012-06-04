class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	#adding a password_digest column to the users table so that we can authenticate users
    add_column :users, :password_digest, :string
  end
end

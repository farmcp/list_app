var search_data = {"index":{"searchIndex":["applicationcontroller","applicationhelper","city","comment","commentscontroller","enumerable","list","listitem","listitemscontroller","listscontroller","object","passwordresetscontroller","passwordresetshelper","relationship","relationshipscontroller","restaurant","restaurantscontroller","sessionscontroller","sessionshelper","staticpagescontroller","staticpageshelper","synccontroller","synchelper","user","usermailer","userscontroller","usershelper","about()","city_state_zip()","contribute()","create()","create()","create()","create()","create()","create()","create()","create()","current_user()","current_user=()","current_user?()","destroy()","destroy()","destroy()","destroy()","destroy()","destroy()","edit()","edit()","fix_phone_number()","follow!()","followers()","following()","following?()","full_name()","full_title()","get_recommendations()","get_sync()","gmaps4rails_address()","gravatar_for()","home()","index()","link_to_phone()","mail_followed_user()","mean()","name_with_state()","new()","new()","new()","new()","new()","password_reset()","redirect_back_or()","search()","select_options()","send_password_reset()","show()","show()","show()","show()","sign_in()","sign_out()","signed_in?()","signed_in_user()","sort_by_frequency()","standard_deviation()","store_location()","syncable_users()","team()","unfollow!()","update()","update()","variance()","welcome_email()","readme_for_app"],"longSearchIndex":["applicationcontroller","applicationhelper","city","comment","commentscontroller","enumerable","list","listitem","listitemscontroller","listscontroller","object","passwordresetscontroller","passwordresetshelper","relationship","relationshipscontroller","restaurant","restaurantscontroller","sessionscontroller","sessionshelper","staticpagescontroller","staticpageshelper","synccontroller","synchelper","user","usermailer","userscontroller","usershelper","staticpagescontroller#about()","restaurant#city_state_zip()","staticpagescontroller#contribute()","commentscontroller#create()","listitemscontroller#create()","listscontroller#create()","passwordresetscontroller#create()","relationshipscontroller#create()","restaurantscontroller#create()","sessionscontroller#create()","userscontroller#create()","sessionshelper#current_user()","sessionshelper#current_user=()","sessionshelper#current_user?()","commentscontroller#destroy()","listitemscontroller#destroy()","listscontroller#destroy()","relationshipscontroller#destroy()","sessionscontroller#destroy()","userscontroller#destroy()","passwordresetscontroller#edit()","userscontroller#edit()","restaurant#fix_phone_number()","user#follow!()","userscontroller#followers()","userscontroller#following()","user#following?()","user#full_name()","applicationhelper#full_title()","synchelper#get_recommendations()","synccontroller#get_sync()","restaurant#gmaps4rails_address()","usershelper#gravatar_for()","staticpagescontroller#home()","userscontroller#index()","applicationhelper#link_to_phone()","usermailer#mail_followed_user()","enumerable#mean()","city#name_with_state()","listscontroller#new()","passwordresetscontroller#new()","restaurantscontroller#new()","sessionscontroller#new()","userscontroller#new()","usermailer#password_reset()","sessionshelper#redirect_back_or()","user::search()","city::select_options()","user#send_password_reset()","listscontroller#show()","restaurantscontroller#show()","synccontroller#show()","userscontroller#show()","sessionshelper#sign_in()","sessionshelper#sign_out()","sessionshelper#signed_in?()","sessionshelper#signed_in_user()","enumerable#sort_by_frequency()","enumerable#standard_deviation()","sessionshelper#store_location()","userscontroller#syncable_users()","staticpagescontroller#team()","user#unfollow!()","passwordresetscontroller#update()","userscontroller#update()","enumerable#variance()","usermailer#welcome_email()",""],"info":[["ApplicationController","","ApplicationController.html","",""],["ApplicationHelper","","ApplicationHelper.html","",""],["City","","City.html","","<p>Schema Information\n<p>Table name: cities\n\n<pre>id           :integer         not null, primary key\nname         ...</pre>\n"],["Comment","","Comment.html","","<p>Schema Information\n<p>Table name: comments\n\n<pre>id            :integer         not null, primary key\nuser_id   ...</pre>\n"],["CommentsController","","CommentsController.html","",""],["Enumerable","","Enumerable.html","",""],["List","","List.html","","<p>Schema Information\n<p>Table name: lists\n\n<pre>id         :integer         not null, primary key\nuser_id    :integer ...</pre>\n"],["ListItem","","ListItem.html","","<p>Schema Information\n<p>Table name: list_items\n\n<pre>id            :integer         not null, primary key\nlist_id ...</pre>\n"],["ListItemsController","","ListItemsController.html","",""],["ListsController","","ListsController.html","",""],["Object","","Object.html","",""],["PasswordResetsController","","PasswordResetsController.html","",""],["PasswordResetsHelper","","PasswordResetsHelper.html","",""],["Relationship","","Relationship.html","","<p>Schema Information\n<p>Table name: relationships\n\n<pre>id          :integer         not null, primary key\nfollower_id ...</pre>\n"],["RelationshipsController","","RelationshipsController.html","",""],["Restaurant","","Restaurant.html","","<p>Schema Information\n<p>Table name: restaurants\n\n<pre>id           :integer         not null, primary key\nname    ...</pre>\n"],["RestaurantsController","","RestaurantsController.html","",""],["SessionsController","","SessionsController.html","",""],["SessionsHelper","","SessionsHelper.html","",""],["StaticPagesController","","StaticPagesController.html","",""],["StaticPagesHelper","","StaticPagesHelper.html","",""],["SyncController","","SyncController.html","",""],["SyncHelper","","SyncHelper.html","",""],["User","","User.html","","<p>Schema Information\n<p>Table name: users\n\n<pre>id                     :integer         not null, primary key\nfirst_name ...</pre>\n"],["UserMailer","","UserMailer.html","",""],["UsersController","","UsersController.html","",""],["UsersHelper","","UsersHelper.html","",""],["about","StaticPagesController","StaticPagesController.html#method-i-about","()",""],["city_state_zip","Restaurant","Restaurant.html#method-i-city_state_zip","()",""],["contribute","StaticPagesController","StaticPagesController.html#method-i-contribute","()","<p>static page for contributing\n"],["create","CommentsController","CommentsController.html#method-i-create","()",""],["create","ListItemsController","ListItemsController.html#method-i-create","()",""],["create","ListsController","ListsController.html#method-i-create","()","<p>POST request for creating a new List\n"],["create","PasswordResetsController","PasswordResetsController.html#method-i-create","()","<p>check to make sure that the user is valid before sending mail\n"],["create","RelationshipsController","RelationshipsController.html#method-i-create","()",""],["create","RestaurantsController","RestaurantsController.html#method-i-create","()","<p>POST action for creating a new restaurant\n"],["create","SessionsController","SessionsController.html#method-i-create","()","<p>POST the information that will create the new session and drop teh cookie\n"],["create","UsersController","UsersController.html#method-i-create","()",""],["current_user","SessionsHelper","SessionsHelper.html#method-i-current_user","()","<p>getter method that doesn’t sign user out\n"],["current_user=","SessionsHelper","SessionsHelper.html#method-i-current_user-3D","(user)","<p>need a setter method for current_user defined in sign_in - reason is the\ncurrent user can change and …\n"],["current_user?","SessionsHelper","SessionsHelper.html#method-i-current_user-3F","(user)",""],["destroy","CommentsController","CommentsController.html#method-i-destroy","()",""],["destroy","ListItemsController","ListItemsController.html#method-i-destroy","()",""],["destroy","ListsController","ListsController.html#method-i-destroy","()","<p>DELETE request for killing a list =&gt; located on the user/:id page for\nshowing a user\n"],["destroy","RelationshipsController","RelationshipsController.html#method-i-destroy","()",""],["destroy","SessionsController","SessionsController.html#method-i-destroy","()","<p>DELETE the cookie and kill the session\n"],["destroy","UsersController","UsersController.html#method-i-destroy","()",""],["edit","PasswordResetsController","PasswordResetsController.html#method-i-edit","()",""],["edit","UsersController","UsersController.html#method-i-edit","()",""],["fix_phone_number","Restaurant","Restaurant.html#method-i-fix_phone_number","()","<p>get rid of all non digits then validate\n"],["follow!","User","User.html#method-i-follow-21","(other_user)","<p>create a relationship between this user’s followedid and the other user’s\nid\n"],["followers","UsersController","UsersController.html#method-i-followers","()","<p>return all followers\n"],["following","UsersController","UsersController.html#method-i-following","()","<p>return all followeds\n"],["following?","User","User.html#method-i-following-3F","(other_user)",""],["full_name","User","User.html#method-i-full_name","()",""],["full_title","ApplicationHelper","ApplicationHelper.html#method-i-full_title","(page_title)","<p>returns the full title on a per page basis\n"],["get_recommendations","SyncHelper","SyncHelper.html#method-i-get_recommendations","(users, location=nil)","<p>create a recommendations engine here - right now just returns all of the\nusers that were inputted and …\n"],["get_sync","SyncController","SyncController.html#method-i-get_sync","()","<p>get recommendations for the useres that are returned from the input\n"],["gmaps4rails_address","Restaurant","Restaurant.html#method-i-gmaps4rails_address","()","<p>pass in the location so that can set model lat/lng data\n"],["gravatar_for","UsersHelper","UsersHelper.html#method-i-gravatar_for","(user, options = {size:''})",""],["home","StaticPagesController","StaticPagesController.html#method-i-home","()",""],["index","UsersController","UsersController.html#method-i-index","()",""],["link_to_phone","ApplicationHelper","ApplicationHelper.html#method-i-link_to_phone","(number_str)",""],["mail_followed_user","UserMailer","UserMailer.html#method-i-mail_followed_user","(user, other_user)","<p>mail followed user\n"],["mean","Enumerable","Enumerable.html#method-i-mean","()",""],["name_with_state","City","City.html#method-i-name_with_state","()",""],["new","ListsController","ListsController.html#method-i-new","()","<p>GET request for displaying how to create a new List\n"],["new","PasswordResetsController","PasswordResetsController.html#method-i-new","()",""],["new","RestaurantsController","RestaurantsController.html#method-i-new","()","<p>GET page for creating a new restaurant\n"],["new","SessionsController","SessionsController.html#method-i-new","()","<p>GET the page that will create a new session\n"],["new","UsersController","UsersController.html#method-i-new","()",""],["password_reset","UserMailer","UserMailer.html#method-i-password_reset","(user)","<p>send the user a password reset email\n"],["redirect_back_or","SessionsHelper","SessionsHelper.html#method-i-redirect_back_or","(default)",""],["search","User","User.html#method-c-search","(query)","<p>create a static method search on a query\n"],["select_options","City","City.html#method-c-select_options","()",""],["send_password_reset","User","User.html#method-i-send_password_reset","()","<p>send the password reset after generating and storing a new token\n"],["show","ListsController","ListsController.html#method-i-show","()","<p>GET request to show lists/:id\n"],["show","RestaurantsController","RestaurantsController.html#method-i-show","()","<p>need to show the restaurant details and comments\n"],["show","SyncController","SyncController.html#method-i-show","()",""],["show","UsersController","UsersController.html#method-i-show","()",""],["sign_in","SessionsHelper","SessionsHelper.html#method-i-sign_in","(user)","<p>sign the user in by placing a cookie with the remember token for that\nperson generated by user model …\n"],["sign_out","SessionsHelper","SessionsHelper.html#method-i-sign_out","()","<p>sign the user out\n"],["signed_in?","SessionsHelper","SessionsHelper.html#method-i-signed_in-3F","()",""],["signed_in_user","SessionsHelper","SessionsHelper.html#method-i-signed_in_user","()",""],["sort_by_frequency","Enumerable","Enumerable.html#method-i-sort_by_frequency","()",""],["standard_deviation","Enumerable","Enumerable.html#method-i-standard_deviation","()",""],["store_location","SessionsHelper","SessionsHelper.html#method-i-store_location","()","<p>Friendly Forwarding use session to store cookies :return_to and the path\nwhere you’re trying to go\n"],["syncable_users","UsersController","UsersController.html#method-i-syncable_users","()",""],["team","StaticPagesController","StaticPagesController.html#method-i-team","()",""],["unfollow!","User","User.html#method-i-unfollow-21","(other_user)","<p>destroy the relationship\n"],["update","PasswordResetsController","PasswordResetsController.html#method-i-update","()","<p>reset the password\n"],["update","UsersController","UsersController.html#method-i-update","()",""],["variance","Enumerable","Enumerable.html#method-i-variance","()",""],["welcome_email","UserMailer","UserMailer.html#method-i-welcome_email","(user)","<p>send the user a welcome email\n"],["README_FOR_APP","","doc/README_FOR_APP.html","","<p>Use this README file to introduce your application and point to useful\nplaces in the API for learning …\n"]]}}
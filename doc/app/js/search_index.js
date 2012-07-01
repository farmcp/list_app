var search_data = {"index":{"searchIndex":["applicationcontroller","applicationhelper","city","list","listitem","listitemscontroller","listscontroller","passwordresetscontroller","passwordresetshelper","relationship","relationshipscontroller","restaurant","restaurantscontroller","sessionscontroller","sessionshelper","staticpagescontroller","staticpageshelper","user","usermailer","userscontroller","usershelper","about()","contribute()","create()","create()","create()","create()","create()","create()","create()","current_user()","current_user=()","current_user?()","destroy()","destroy()","destroy()","destroy()","destroy()","edit()","edit()","follow!()","followers()","following()","following?()","full_name()","full_title()","gravatar_for()","home()","index()","new()","new()","new()","new()","new()","password_reset()","redirect_back_or()","select_options()","send_password_reset()","show()","show()","sign_in()","sign_out()","signed_in?()","signed_in_user()","store_location()","team()","unfollow!()","update()","update()","welcome_email()","readme_for_app"],"longSearchIndex":["applicationcontroller","applicationhelper","city","list","listitem","listitemscontroller","listscontroller","passwordresetscontroller","passwordresetshelper","relationship","relationshipscontroller","restaurant","restaurantscontroller","sessionscontroller","sessionshelper","staticpagescontroller","staticpageshelper","user","usermailer","userscontroller","usershelper","staticpagescontroller#about()","staticpagescontroller#contribute()","listitemscontroller#create()","listscontroller#create()","passwordresetscontroller#create()","relationshipscontroller#create()","restaurantscontroller#create()","sessionscontroller#create()","userscontroller#create()","sessionshelper#current_user()","sessionshelper#current_user=()","sessionshelper#current_user?()","listitemscontroller#destroy()","listscontroller#destroy()","relationshipscontroller#destroy()","sessionscontroller#destroy()","userscontroller#destroy()","passwordresetscontroller#edit()","userscontroller#edit()","user#follow!()","userscontroller#followers()","userscontroller#following()","user#following?()","user#full_name()","applicationhelper#full_title()","usershelper#gravatar_for()","staticpagescontroller#home()","userscontroller#index()","listscontroller#new()","passwordresetscontroller#new()","restaurantscontroller#new()","sessionscontroller#new()","userscontroller#new()","usermailer#password_reset()","sessionshelper#redirect_back_or()","city::select_options()","user#send_password_reset()","listscontroller#show()","userscontroller#show()","sessionshelper#sign_in()","sessionshelper#sign_out()","sessionshelper#signed_in?()","sessionshelper#signed_in_user()","sessionshelper#store_location()","staticpagescontroller#team()","user#unfollow!()","passwordresetscontroller#update()","userscontroller#update()","usermailer#welcome_email()",""],"info":[["ApplicationController","","ApplicationController.html","",""],["ApplicationHelper","","ApplicationHelper.html","",""],["City","","City.html","","<p>Schema Information\n<p>Table name: cities\n\n<pre>id           :integer         not null, primary key\nname         ...</pre>\n"],["List","","List.html","","<p>Schema Information\n<p>Table name: lists\n\n<pre>id         :integer         not null, primary key\nuser_id    :integer ...</pre>\n"],["ListItem","","ListItem.html","","<p>Schema Information\n<p>Table name: list_items\n\n<pre>id            :integer         not null, primary key\nlist_id ...</pre>\n"],["ListItemsController","","ListItemsController.html","",""],["ListsController","","ListsController.html","",""],["PasswordResetsController","","PasswordResetsController.html","",""],["PasswordResetsHelper","","PasswordResetsHelper.html","",""],["Relationship","","Relationship.html","","<p>Table name: relationships\n\n<pre>id          :integer         not null, primary key\nfollower_id :integer\nfollowed_id ...</pre>\n"],["RelationshipsController","","RelationshipsController.html","",""],["Restaurant","","Restaurant.html","","<p>Schema Information\n<p>Table name: restaurants\n\n<pre>id           :integer         not null, primary key\nname    ...</pre>\n"],["RestaurantsController","","RestaurantsController.html","",""],["SessionsController","","SessionsController.html","",""],["SessionsHelper","","SessionsHelper.html","",""],["StaticPagesController","","StaticPagesController.html","",""],["StaticPagesHelper","","StaticPagesHelper.html","",""],["User","","User.html","","<p>Schema Information\n<p>Table name: users\n\n<pre>id                     :integer         not null, primary key\nfirst_name ...</pre>\n"],["UserMailer","","UserMailer.html","",""],["UsersController","","UsersController.html","",""],["UsersHelper","","UsersHelper.html","",""],["about","StaticPagesController","StaticPagesController.html#method-i-about","()",""],["contribute","StaticPagesController","StaticPagesController.html#method-i-contribute","()","<p>static page for contributing\n"],["create","ListItemsController","ListItemsController.html#method-i-create","()",""],["create","ListsController","ListsController.html#method-i-create","()","<p>POST request for creating a new List\n"],["create","PasswordResetsController","PasswordResetsController.html#method-i-create","()",""],["create","RelationshipsController","RelationshipsController.html#method-i-create","()",""],["create","RestaurantsController","RestaurantsController.html#method-i-create","()","<p>POST action for creating a new restaurant\n"],["create","SessionsController","SessionsController.html#method-i-create","()","<p>POST the information that will create the new session and drop teh cookie\n"],["create","UsersController","UsersController.html#method-i-create","()",""],["current_user","SessionsHelper","SessionsHelper.html#method-i-current_user","()","<p>getter method that doesn’t sign user out\n"],["current_user=","SessionsHelper","SessionsHelper.html#method-i-current_user-3D","(user)","<p>need a setter method for current_user defined in sign_in - reason is the\ncurrent user can change and …\n"],["current_user?","SessionsHelper","SessionsHelper.html#method-i-current_user-3F","(user)",""],["destroy","ListItemsController","ListItemsController.html#method-i-destroy","()",""],["destroy","ListsController","ListsController.html#method-i-destroy","()","<p>DELETE request for killing a list =&gt; located on the user/:id page for\nshowing a user\n"],["destroy","RelationshipsController","RelationshipsController.html#method-i-destroy","()",""],["destroy","SessionsController","SessionsController.html#method-i-destroy","()","<p>DELETE the cookie and kill the session\n"],["destroy","UsersController","UsersController.html#method-i-destroy","()",""],["edit","PasswordResetsController","PasswordResetsController.html#method-i-edit","()",""],["edit","UsersController","UsersController.html#method-i-edit","()",""],["follow!","User","User.html#method-i-follow-21","(other_user)",""],["followers","UsersController","UsersController.html#method-i-followers","()",""],["following","UsersController","UsersController.html#method-i-following","()",""],["following?","User","User.html#method-i-following-3F","(other_user)",""],["full_name","User","User.html#method-i-full_name","()",""],["full_title","ApplicationHelper","ApplicationHelper.html#method-i-full_title","(page_title)","<p>returns the full title on a per page basis\n"],["gravatar_for","UsersHelper","UsersHelper.html#method-i-gravatar_for","(user, options = {size:50})",""],["home","StaticPagesController","StaticPagesController.html#method-i-home","()",""],["index","UsersController","UsersController.html#method-i-index","()",""],["new","ListsController","ListsController.html#method-i-new","()","<p>GET request for displaying how to create a new List\n"],["new","PasswordResetsController","PasswordResetsController.html#method-i-new","()",""],["new","RestaurantsController","RestaurantsController.html#method-i-new","()","<p>GET page for creating a new restaurant\n"],["new","SessionsController","SessionsController.html#method-i-new","()","<p>GET the page that will create a new session\n"],["new","UsersController","UsersController.html#method-i-new","()",""],["password_reset","UserMailer","UserMailer.html#method-i-password_reset","(user)",""],["redirect_back_or","SessionsHelper","SessionsHelper.html#method-i-redirect_back_or","(default)",""],["select_options","City","City.html#method-c-select_options","()",""],["send_password_reset","User","User.html#method-i-send_password_reset","()",""],["show","ListsController","ListsController.html#method-i-show","()","<p>GET request to show lists/:id\n"],["show","UsersController","UsersController.html#method-i-show","()",""],["sign_in","SessionsHelper","SessionsHelper.html#method-i-sign_in","(user)","<p>sign the user in by placing a cookie with the remember token for that\nperson generated by user model …\n"],["sign_out","SessionsHelper","SessionsHelper.html#method-i-sign_out","()","<p>sign the user out\n"],["signed_in?","SessionsHelper","SessionsHelper.html#method-i-signed_in-3F","()",""],["signed_in_user","SessionsHelper","SessionsHelper.html#method-i-signed_in_user","()",""],["store_location","SessionsHelper","SessionsHelper.html#method-i-store_location","()","<p>Friendly Forwarding use session to store cookies :return_to and the path\nwhere you’re trying to go\n"],["team","StaticPagesController","StaticPagesController.html#method-i-team","()",""],["unfollow!","User","User.html#method-i-unfollow-21","(other_user)",""],["update","PasswordResetsController","PasswordResetsController.html#method-i-update","()",""],["update","UsersController","UsersController.html#method-i-update","()",""],["welcome_email","UserMailer","UserMailer.html#method-i-welcome_email","(user)",""],["README_FOR_APP","","doc/README_FOR_APP.html","","<p>Use this README file to introduce your application and point to useful\nplaces in the API for learning …\n"]]}}
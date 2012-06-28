     ______  _           _ _
    (____  \(_)_        | (_)     _
     ____)  )_| |_  ____| |_  ___| |_
    |  __  (| |  _)/ _  ) | |/___)  _)
    | |__)  ) | |_( (/ /| | |___ | |__
    |______/|_|\___)____)_|_(___/ \___)


Install Rails:
----------------
      http://installfest.railsbridge.org/installfest/choose_your_operating_system?back=installfest%23step3


Install Postgres:
-----------------
      brew install postgresql

Install Rails ERD
-----------------
http://rails-erd.rubyforge.org/install.html
	
	$ brew install cairo pango graphviz 
	$ rake erd
	
Setup for local
---------------
	$ bundle install
	$ rake db:migrate
	$ rake db:populate

To Dos:
--------

1. ~~Add models for lists (done), list_items (done), restaurants (done)~~
2. ~~Create a Friends tab (done)~~
2. ~~Allow users to create and delete list_items~~ 
2. ~~Add :active field to Restaurants - not accessible through users and forms. Change :postal_code to :string~~
2. Allow users to click through list_items to view details on restaurants
3. Able to search users on app through Friends tab and also sync with Friends' lists
4. Integrate google maps for each of the lists in each city
2. ~~Allow users to follow each other~~
2. ~~Bug: users that follow can't see each other's lists~~
2. Email verification - forgotten passwords, account activation
2. Get off of Gravatar
2. Validation for places to eat
3. Allow users to sync with selected people they follow
4. Add facebook connect that suggests friends already in their fb network to follow
5. Create JSON API so we can start the native iOS app
5. Add SSL/https to signon

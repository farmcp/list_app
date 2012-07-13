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
2. ~~Allow users to follow each other~~
2. ~~Bug: users that follow can't see each other's lists~~
3. ~~Able to search users on app through Friends tab - add Search button to friends tab (working on this)~~
4. ~~Integrate google maps for each of the lists in each city~~
5. ~~BUG: maps not fully accurate with geocoding~~
2. ~~Allow users to click through list_items to view details on restaurants~~
6. ~~Add images to cities~~
2. Add SSL/https to signon
4. Add facebook connect that suggests friends already in their fb network to follow
2. Validation for places to eat - know when someone enters a valid restaurant and populating the database
3. Allow users to sync with selected people they follow
4. Add a Friends tab and allows you to view all your followers and people you follow - this will replace current `users_path`
4. Adding user's comments to each list item
2. http://www.opentable.com/info/affiliates.aspx - add open table reservations
5. Get off of Gravatar - handle image storage with aws S3
2. Create JSON API so we can start the native iOS app
2. Email verification - account activation


Gem Documentation:
-------------------
`gmaps4rails` https://github.com/apneadiving/Google-Maps-for-Rails

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
2. Need to sesarch internal list and not just facebook (since we allow users to upload to our db)
2. Need to make sure we update our database when facebook is updated
2. Phone numbers don't support 1 in front of digits
2. Need to add Hawaii, New York, LA, Chicago to list of available cities - see list_controller (new)
4. Create a better algorithm for restaurant recommendations
2. Add directions to restaurants (button on the restaurant show)
2. http://www.opentable.com/info/affiliates.aspx - add open table reservations
5. Get off of Gravatar - handle image storage with aws S3
2. Create JSON API so we can start the native iOS app
2. Email verification - account activation
4. Don't actually delete stuff. Set hidden = true
2. Add SSL/https to signon
3. favicon

Gem Documentation:
-------------------
`gmaps4rails` https://github.com/apneadiving/Google-Maps-for-Rails

`google-analytics-rails` https://github.com/bgarret/google-analytics-rails

# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130221082902) do

  create_table "checkins", :force => true do |t|
    t.text     "body"
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "checkins", ["restaurant_id"], :name => "index_checkins_on_restaurant_id"
  add_index "checkins", ["user_id"], :name => "index_checkins_on_user_id"

  create_table "cities", :force => true do |t|
    t.string   "name",         :limit => 64,                    :null => false
    t.string   "abbreviation", :limit => 16,                    :null => false
    t.string   "state",        :limit => 4,                     :null => false
    t.boolean  "active",                     :default => false, :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.float    "longitude"
    t.float    "latitude"
  end

  add_index "cities", ["abbreviation"], :name => "index_cities_on_abbreviation"
  add_index "cities", ["active"], :name => "index_cities_on_active"
  add_index "cities", ["latitude"], :name => "index_cities_on_latitude"
  add_index "cities", ["longitude"], :name => "index_cities_on_longitude"
  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["state"], :name => "index_cities_on_state"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "comments", ["restaurant_id"], :name => "index_comments_on_restaurant_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "edit_requests", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.boolean  "accepted",      :default => false
    t.boolean  "rejected",      :default => false
    t.text     "params"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "edit_requests", ["accepted"], :name => "index_edit_requests_on_accepted"
  add_index "edit_requests", ["rejected"], :name => "index_edit_requests_on_rejected"
  add_index "edit_requests", ["restaurant_id"], :name => "index_edit_requests_on_restaurant_id"
  add_index "edit_requests", ["user_id"], :name => "index_edit_requests_on_user_id"

  create_table "list_items", :force => true do |t|
    t.integer  "list_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  add_index "list_items", ["list_id", "restaurant_id"], :name => "index_list_items_on_list_id_and_restaurant_id", :unique => true
  add_index "list_items", ["user_id"], :name => "index_list_items_on_user_id"

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "city_id"
  end

  add_index "lists", ["city_id"], :name => "index_lists_on_city_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "picture_url"
    t.string   "phone_number"
    t.string   "category"
    t.string   "address"
    t.string   "postal_code"
    t.string   "comments"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "city_id"
    t.boolean  "active"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "yelp_url"
    t.string   "fb_place_id"
    t.string   "website_url"
  end

  add_index "restaurants", ["fb_place_id"], :name => "index_restaurants_on_fb_place_id"
  add_index "restaurants", ["yelp_url"], :name => "index_restaurants_on_yelp_url"

  create_table "stories", :force => true do |t|
    t.integer  "user_id"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "restaurant_id"
  end

  add_index "stories", ["subject_type", "subject_id"], :name => "index_stories_on_subject_type_and_subject_id"
  add_index "stories", ["user_id"], :name => "index_stories_on_user_id"

  create_table "sub_cities", :force => true do |t|
    t.string  "name"
    t.integer "city_id"
  end

  add_index "sub_cities", ["city_id"], :name => "index_sub_cities_on_city_id"
  add_index "sub_cities", ["name"], :name => "index_sub_cities_on_name"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "fb_id"
    t.string   "provider"
    t.string   "image_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end

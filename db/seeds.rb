# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  City.destroy_all
  # oops this one needs migration rollback
  # SubCity.destroy_all
  User.destroy_all

  sf  = City.create(name: 'San Francisco', abbreviation: "SF", state: "CA", active: true, longitude: 122.68, latitude: 37.75)
  bos = City.create(name: "Boston", abbreviation: "BOS", state: "MA", active: true, longitude: 71.03, latitude: 42.37)

  sf_cities = [
    'oakland',
    'pleasanton',
    'palo alto',
    'daly city',
    'mountain view',
    'san jose',
    'berkeley',
    'fremont',
    'emeryville',
  ]
  bos_cities = [
    'cambridge',
    'lowell',
    'brockton',
    'lynn',
    'newton',
    'somerville',
    'lawrence',
    'quincy',
    'allston',
    'peabody',
    'nashua',
    'framingham',
    'waltham',
    'worcester',
  ]
  sf_cities.each do |sub_city|
    sf.sub_cities.create!(name: sub_city.downcase)
  end
  bos_cities.each do |sub_city|
    bos.sub_cities.create!(name: sub_city.downcase)
  end

  users = [
    {
      first_name: "Hwan-Joon",
      last_name: "Choi",
      email: "hc5duke@gmail.com",
      password: "password",
      password_confirmation: "password",
      remember_token: "AAACFUv5pgEMBANZCGBJhBkjKFYBSs4tfHq6Iu4quwatEGF0L1XWbwZAealI0AD43gZBohXr9Rvd61jnhLil9w5ZCdfu8YvIZD",
      admin: true,
      password_reset_token: nil,
      password_reset_sent_at: nil,
      fb_id: "1301200",
      provider: "facebook",
      image_url: "http://graph.facebook.com/1301200/picture?type=square"
    },
    {
      first_name: "Matt",
      last_name: "Johanssen",
      email: "matt.johanssen@gmail.com",
      password: "password",
      password_confirmation: "password",
      remember_token: "AAACFUv5pgEMBAJcV1J9iS1ZC2sZBWDBGNCvghJnO3iBizLLXu1dwZA670lkZA4SpjCY6eZAxlMMG5Og4ztTZCHavzY2jnzfZAJYVB8PRUUUZAwZDZD",
      admin: false,
      password_reset_token: nil,
      password_reset_sent_at: nil,
      fb_id: "1314428840",
      provider: "facebook",
      image_url: "http://graph.facebook.com/1314428840/picture?type=square"
    }
  ].map do |options|
    user = User.new
    options.each do |key, value|
      user.send("#{key}=", value)
    end
    user.save!
    user
  end

  Relationship.create(follower_id: users[0].id, followed_id: users[1].id)
  Relationship.create(follower_id: users[1].id, followed_id: users[0].id)
end

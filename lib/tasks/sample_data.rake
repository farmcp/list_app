namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(first_name: "Christopher", last_name: "Farm",
      email: "farm.cp@gmail.com",
      password: "foobar",
      password_confirmation: "foobar")
    sf = City.create!(name:'San Francisco', abbreviation: 'SF', state: 'CA', active: true)
    bos = City.create!(name:'Boston', abbreviation:'BOS', state:'MA', active:true)
    hon = City.create!(name:'Honolulu',abbreviation:'HON', state:'HI', active:true)
    tin = Restaurant.create!(name: 'Tin Vietnamese Cuisine', phone_number:'4158827188', category: 'Vietnamese', address: '937 Howard St', postal_code:'94103',city_id:sf.id)


    #not attr_accessible in user model
    admin.toggle!(:admin)
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name

      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:first_name => first_name, :last_name => last_name,
        email: email,
        password: password,
        password_confirmation: password)
    end

    make_relationships
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each{|followed| user.follow!(followed)}
  followers.each {|follower| follower.follow!(user)}
end

namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(first_name: "Christopher", last_name: "Farm",
			email: "farm.cp@gmail.com",
			password: "foobar",
			password_confirmation: "foobar")

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

		#make relationships
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

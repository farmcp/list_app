# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean         default(FALSE)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  fb_id                  :string(255)
#  provider               :string(255)
#  image_url              :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  #checks to authenticate users. as long as there is a password_digest field in the database and :password and :password_confirmation
  #then has_secure_password will encrypt, then check that pass and pass_conf match then store in pass_digest
  has_secure_password

  #every user can have many lists
  has_many :lists, :dependent => :destroy

  #has many list_items
  has_many :list_items

  #has many restaurants through list_items
  has_many :restaurants, :through => :list_items

  #has many cities through lists
  has_many :cities, :through => :lists

  #every user has many relationships - also should destroy the relationship if the user is destroyed
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy

  #can say User.followed_users => returns an array of followed users for the User and uses the relationships table followed_id as the source
  has_many :followed_users, through: :relationships, source: :followed

  #can say User.followers => returns an array of followers for the user. using the Relationship class and using reverse_relationships
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  #a user has many comments
  has_many :comments, :dependent => :destroy

  #before you save the user to the database - downcase the email
  before_save { |user| user.email = email.downcase }
  #before the save create the remember_token for the specific user automatically
  before_save :create_remember_token

  #validates the user password for length and presence
  validates :password, :presence => true, :length => { :minimum => 4, :maximum => 50}
  validates :password_confirmation, :presence => true, :length => {:minimum => 4, :maximum => 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, length: {maximum: 50}
  validates :last_name, length: {maximum: 50}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  RESTAURANTS_REQUIRED_TO_EDIT = 25

  def full_name
    "#{first_name} #{last_name}"
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  #create a relationship between this user's followedid and the other user's id
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)

    #send a mail to user that is followed - This might need to be placed in a job later
    UserMailer.mail_followed_user(self, other_user).deliver
  end

  #destroy the relationship
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  #send the password reset after generating and storing a new token
  def send_password_reset
    # generate a new token to reset password after email is asked for
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    # save the token and the password time
    save(validate: false)
    # send the mail with the token
    UserMailer.password_reset(self).deliver
  end

  # send an invite to a new user email address
  def send_invite_to_new_user(new_user_email)
    UserMailer.invite_user(self, new_user_email).deliver
  end

  #create a static method search on a query
  def self.search(query)
    if query.present?
      results = []
      queries = query.split(' ')
      queries.each do |q|
        results << find(:all, conditions: ['lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{q.downcase}%","%#{q.downcase}%" ])
      end
      return results.uniq.flatten
    else
      find(:all)
    end
  end

  def avatar_url(size = 50)
    return image_url unless image_url.blank?
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?r=r&size=#{size}"
  end

  def fb_post(message)
    if self.provider == 'facebook'
      begin
        me = FbGraph::User.me(self.remember_token)
        me.feed!(message: message)
      rescue
        # handle failed user post - do nothing for now
      end
    end
  end

  def list_for(restaurant)
    lists.find_or_create_by_city_id(restaurant.city_id)
  end

  # THIS IS A HACK RIGHT NOW - NEED TO FIX THIS LATER.
  # CURRENTLY USING FARM'S ACCESS TOKEN TO GET FB STUFF
  def fb_search_token
    return remember_token if fb_id
    User.find_by_email('farm.cp@gmail.com').remember_token
  end

  def can_edit
    self.restaurants.count >= RESTAURANTS_REQUIRED_TO_EDIT
  end

  private

  def create_remember_token
    if self.provider != 'facebook'
      self.remember_token = SecureRandom.urlsafe_base64
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.fb_id = auth['uid']
      user.remember_token = auth['credentials']['token']
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
      user.email = auth['info']['email']
      user.image_url = auth['info']['image']
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      UserMailer.welcome_email(user).deliver
    end
  end
end

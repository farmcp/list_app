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
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  #checks to authenticate users. as long as there is a password_digest field in the database and :password and :password_confirmation
  #then has_secure_password will encrypt, then check that pass and pass_conf match then store in pass_digest
  has_secure_password

  #every user can have many lists
  has_many :lists

  #every user has many relationships - also should destroy the relationship if the user is destroyed
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy

  #can say User.followed_users => returns an array of followed users for the User and uses the relationships table followed_id as the source
  has_many :followed_users, through: :relationships, source: :followed

  #can say User.followers => returns an array of followers for the user. using the Relationship class and using reverse_relationships
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  #before you save the user to the database - downcase the email
  before_save { |user| user.email = email.downcase }
  #before the save create the remember_token for the specific user automatically
  before_save :create_remember_token

  #validates the user password for length and presence
  validates :password, :presence => true, :length => { :minimum => 6, :maximum => 50}
  validates :password_confirmation, :presence => true, :length => {:minimum => 6, :maximum => 50}


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, length: {maximum: 50}
  validates :last_name, length: {maximum: 50}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  def full_name
    "#{first_name} #{last_name}"
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def send_password_reset
    # generate a new token to reset password after email is asked for
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    # save the token and the password time
    save(validate: false)
    # send the mail with the token
    UserMailer.password_reset(self).deliver
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end

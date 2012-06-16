# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  #checks to authenticate users. as long as there is a password_digest field in the database and :password and :password_onfirmation
  #then has_secure_password will encrypt, then check that pass and pass_conf match then store in pass_digest
  has_secure_password

  #every user can have many lists
  has_many :lists

  #before you save the user to the database - downcase the email
  before_save { |user| user.email = email.downcase }
  #before the save create the remember_token for the specific user automatically
  before_save :create_remember_token

  #validates the user password for length and presence
  validates :password, :presence => true, :length => { :minimum => 6, :maximum => 50}
  validates :password_confirmation, :presence => true, :length => {:minimum => 6, :maximum => 50}


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end

# == Schema Information
#
# Table name: lists
#
#  id         :integer         not null, primary key
#  city       :string(255)
#  state      :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class List < ActiveRecord::Base
  attr_accessible :city, :state

  #this is a one to many relationship with a user. A user can have many lists.
  belongs_to :user

  #need to validate the user_id, city and state. Eventually need to check if the city and state are real
  validates :user_id, presence: true
  validates :city, presence: true
  validates :state, presence: true
end

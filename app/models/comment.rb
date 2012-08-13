# == Schema Information
#
# Table name: comments
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  restaurant_id :integer
#  body          :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Comment < ActiveRecord::Base
  acts_as_story
  attr_accessible :body, :restaurant_id, :user_id

  belongs_to :restaurant
  belongs_to :user
end

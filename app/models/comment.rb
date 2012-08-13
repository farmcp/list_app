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
  attr_accessible :body, :restaurant_id, :user_id
  belongs_to :restaurant
  belongs_to :user

  has_one :story, :as => :subject, :dependent => :destroy
  after_create :storify!
  def storify!
    build_story(:user => user).save!
  end
end

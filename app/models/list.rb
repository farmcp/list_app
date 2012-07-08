# == Schema Information
#
# Table name: lists
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  city_id    :integer
#

class List < ActiveRecord::Base
  attr_accessible :user_id, :city_id

  belongs_to :user
  belongs_to :city
  has_many :list_items, :dependent => :destroy

  validates :user_id, :city_id, :presence => true
end

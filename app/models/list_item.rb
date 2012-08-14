# == Schema Information
#
# Table name: list_items
#
#  id            :integer         not null, primary key
#  list_id       :integer
#  restaurant_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class ListItem < ActiveRecord::Base
  acts_as_story :story_fields => [:restaurant]
  attr_accessible :restaurant_id, :list_id

  belongs_to :list
  belongs_to :restaurant
  belongs_to :user
  has_one :city, :through => :list

  validates_uniqueness_of :restaurant_id, :scope => :list_id

  before_create :find_user

  private

  def find_user
    self.user = list.user
  end
end

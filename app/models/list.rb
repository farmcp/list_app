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
  acts_as_story
  attr_accessible :user_id, :city_id

  belongs_to :user
  belongs_to :city
  has_many :list_items, dependent: :destroy
  has_many :restaurants, through: :list_items

  validates :user_id, :city_id, :presence => true
  validates_uniqueness_of :city_id, scope: :user_id

  MAX_ITEMS_PER_LIST = 20

  def list_item_for(restaurant)
    list_items.find_or_create_by_restaurant_id(restaurant.id)
  end
end

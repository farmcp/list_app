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
  attr_accessible :restaurant_id, :list_id
  belongs_to :list
  belongs_to :restaurant
  belongs_to :user
  has_one :city, :through => :list

  validates_uniqueness_of :restaurant_id, :scope => :list_id

  before_create :find_user

  has_one :story, :as => :subject, :dependent => :destroy
  after_create :storify!
  def storify!
    build_story(:user => user).save!
  end

  private

  def find_user
    self.user = list.user
  end
end

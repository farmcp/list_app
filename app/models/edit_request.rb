class EditRequest < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  attr_accessible :approved, :params, :restaurant_id

  validates_presence_of :user_id, :restaurant_id
end

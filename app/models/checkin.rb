class Checkin < ActiveRecord::Base
  acts_as_story :story_fields => [:restaurant]
  attr_accessible :user_id, :restaurant_id, :body

  belongs_to :user
  belongs_to :restaurant

end
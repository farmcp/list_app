class Story < ActiveRecord::Base
  belongs_to :user
  attr_accessible :subject_id, :subject_type
end

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
  belongs_to :user
  belongs_to :city

  validates_associated :user
  validates_associated :city
end

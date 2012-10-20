# == Schema Information
#
# Table name: sub_cities
#
#  name    :string(255)
#  city_id :integer
#

class SubCity < ActiveRecord::Base
  belongs_to :city
  attr_accessible :name
  validate :city, :name, :presence => true
  validate :name, :uniqueness => true

  def name_downcased; name.downcase; end
end

class SubCity < ActiveRecord::Base
  belongs_to :city
  attr_accessible :name
  validate :city, :name, :presence => true
  validate :name, :uniqueness => true
end

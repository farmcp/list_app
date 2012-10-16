# == Schema Information
#
# Table name: cities
#
#  id           :integer         not null, primary key
#  name         :string(64)      not null
#  abbreviation :string(16)      not null
#  state        :string(4)       not null
#  active       :boolean         default(FALSE), not null
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class City < ActiveRecord::Base
  attr_accessible :abbreviation, :active, :name, :state, :latitude, :longitude

  #each restaurant is unique and each city can have many of the restaurants
  has_many :restaurants
  has_many :sub_cities
  has_many :lists

  def self.select_options
    where(:active => true).map{|city| [city.name, city.id]}
  end

  def name_with_state
    state.present? ? "#{name}, #{state}" : name
  end
end

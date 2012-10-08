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
#  longitude    :float
#  latitude     :float
#

class City < ActiveRecord::Base
  attr_accessible :abbreviation, :active, :name, :state

  #each restaurant is unique and each city can have many of the restaurants
  has_many :restaurants
  has_many :sub_cities
  has_one :list

  def self.select_options
    where(:active => true).map{|city| [city.name, city.id]}
  end

  def name_with_state
    state.present? ? "#{name}, #{state}" : name
  end

  def fb_center
    [latitude, longitude].join(',')
  end

  def get_sub_cities_names
    names = []
    self.sub_cities.each do |sub_city|
      names << sub_city.name.downcase
    end

    return names
  end
end

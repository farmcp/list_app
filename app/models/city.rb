class City < ActiveRecord::Base
  attr_accessible :abbreviation, :active, :name, :state
end

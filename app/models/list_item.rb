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
  # attr_accessible :title, :body
  attr_accessible :restaurant_id, :list_id
  belongs_to :list
  belongs_to :restaurant

  #TO DO: need to create methods so that you can only have one unique restaurant per list
end


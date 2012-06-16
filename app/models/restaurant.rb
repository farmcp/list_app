# == Schema Information
#
# Table name: restaurants
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  picture_url  :string(255)
#  phone_number :string(255)
#  category     :string(255)
#  address      :string(255)
#  postal_code  :integer
#  comments     :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  city_id      :integer
#


class Restaurant < ActiveRecord::Base
  # attr_accessible :title, :body
  #a restaurant can belong to many cities (especially if it's a restaurant chain)n
  belongs_to :cities 

  
end

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
#  postal_code  :string(255)
#  comments     :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  city_id      :integer
#  active       :boolean
#  latitude     :float
#  longitude    :float
#  gmaps        :boolean
#

class Restaurant < ActiveRecord::Base
  # attr_accessible :title, :body
  #not sure we want to expose all fo these fields
  attr_accessible :name, :phone_number, :category, :address, :postal_code, :city_id

  #a restaurant belongs to many cities (especially if it's a restaurant chain)
  belongs_to :cities
  has_one :list_item

  validates :name, :presence => true
  validates :phone_number, :presence => true, :format => {with: /\d{10}/, message: "(Only 10 digit numbers are allowed)"}, numericality: {only_integer: true}
  validates :address, :presence => true
  validates :postal_code, :presence => true

  acts_as_gmappable
  def gmaps4rails_address
    "#{self.address}, #{City.find(self.city_id)}, #{self.postal_code}"
  end
end

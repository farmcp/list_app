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
#  yelp_url     :string(255)
#

class Restaurant < ActiveRecord::Base
  acts_as_gmappable

  # attr_accessible :title, :body
  #not sure we want to expose all fo these fields
  attr_accessible :name, :phone_number, :category, :address, :postal_code, :city_id

  #a restaurant belongs to a single city (create new entry for each restaurant chain location)
  belongs_to :city
  has_one :list_item, :dependent => :destroy

  #a restaurant has many comments and the comments are dependent that the restaurant exists
  has_many :comments, :dependent => :destroy

  validates :name, :presence => true
  validates :phone_number, allow_blank: true, :format => {with: /\d{10}/, message: "(Only 10 digit numbers are allowed)"}, numericality: {only_integer: true}
  validates :address, :presence => true
  validates :postal_code, :presence => true
  validates :yelp_url, :presence => true, :uniqueness => true

  before_validation :fix_phone_number

  #pass in the location so that can set model lat/lng data
  def gmaps4rails_address
    "#{address}, #{city_state_zip}"
  end

  def city_state_zip
    "#{city.name}, #{city.state} #{postal_code}"
  end

  #get rid of all non digits then validate
  def fix_phone_number
    self.phone_number = phone_number.to_s.gsub(/\D/, '')
  end
end

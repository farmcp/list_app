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
#  fb_place_id  :string(255)
#

class Restaurant < ActiveRecord::Base
  acts_as_gmappable

  # attr_accessible :title, :body
  #not sure we want to expose all fo these fields
  attr_accessible :name, :phone_number, :category, :address, :postal_code, :city_id, :active, :yelp_url, :picture_url, :fb_place_id, :latitude, :longitude, :website_url

  #a restaurant belongs to a single city (create new entry for each restaurant chain location)
  belongs_to :city
  has_one :list_item, :dependent => :destroy

  #a restaurant has many comments and the comments are dependent that the restaurant exists
  has_many :comments, :dependent => :destroy

  validates :name, :presence => true
  validates :phone_number, allow_blank: true, :format => {with: /\d{10}/, message: "(Only 10 digit numbers are allowed)"}, numericality: {only_integer: true}

  before_validation :fix_phone_number

  #pass in the location so that can set model lat/lng data
  def gmaps4rails_address
    "#{address}, #{city_state_zip}"
  end

  def gmaps4rails_infowindow
    "<img src=\"#{picture_url}\" width='40' height='40' style='float:left; margin-right:15px;'>
    <b>#{name}</b>
    <br/>
    #{address}
    <br/>
    #{city_state_zip}"
  end

  def city_state_zip
    "#{city.name}, #{city.state} #{postal_code}"
  end

  #get rid of all non digits then validate
  def fix_phone_number
    number = phone_number.to_s.gsub(/\D/, '')
    number = number[1..-1] if number.starts_with?('1')
    self.phone_number = number
  end

  def self.in(city_id)
    where(:city_id => city_id)
  end

  def self.search(query)
    results = [search_by_yelp(query)  ].flatten
    results = [search_by_prefix(query)].flatten if results.blank?
    results = [search_rest(query)     ].flatten if results.blank?
    results
  end

  def self.create_from_facebook(fb_id, city_id)
    fetched_result = FbGraph::Place.fetch(fb_id)
    if fetched_result.website
      website = fetched_result.website.split(' ')[0]
      website = "http://#{website}" unless website.match(/^https?:\/\//)

      create!(
        :name => fetched_result.name,
        :picture_url => fetched_result.picture,
        :phone_number => fetched_result.phone,
        :category => fetched_result.category,
        :address => fetched_result.location.street,
        :postal_code => fetched_result.location.zip,
        :city_id => city_id,
        :active => true,
        :fb_place_id => fetched_result.identifier.to_s,
        :latitude => fetched_result.location.latitude,
        :longitude => fetched_result.location.longitude,
        :website_url => website
      )
    else
      create!(
        :name => fetched_result.name,
        :picture_url => fetched_result.picture,
        :phone_number => fetched_result.phone,
        :category => fetched_result.category,
        :address => fetched_result.location.street,
        :postal_code => fetched_result.location.zip,
        :city_id => city_id,
        :active => true,
        :fb_place_id => fetched_result.identifier.to_s,
        :latitude => fetched_result.location.latitude,
        :longitude => fetched_result.location.longitude
      )
    end
  end

  private

  def self.search_by_yelp(query)
    where(:yelp_url => query)
  end

  def self.search_by_prefix(query)
    where(['name ilike ?', "#{query}%"])
  end

  def self.search_rest(query)
    where(['name ilike ?', "%#{query}%"])
  end
end

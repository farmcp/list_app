require 'nokogiri'
require 'open-uri'

class Yelp
  def self.parse(url)
    resto = Restaurant.new
    data = fetch(url)
    city_name = (data/'span[itemprop=addressLocality]').inner_text
    city = City.where(:name => city_name).first
    return nil unless city

    city_hash = {
      name:         (data/'#bizInfoHeader'/:h1).inner_text.strip,
      phone_number: (data/'#bizPhone').inner_text,
      category:     (data/'#cat_display').inner_text.strip.split(/\W+/),
      address:      (data/'span[itemprop=streetAddress]').inner_text.strip,
      postal_code:  (data/'span[itemprop=postalCode]').inner_text.strip,
      city_id:      city.id,
      active:       true,
      yelp_url:     url.split('?').first.split('/').last,
    }
    Restaurant.new(city_hash)
  end

  def self.fetch(url)
    Nokogiri::HTML(open(url))
  end
end

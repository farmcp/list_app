class OneOffs
  # OneOffs.add_sub_cities
  def self.add_sub_cities
    # SF
    sf = City.find_by_name('San Francisco')
    sf_cities = [
      'oakland',
      'pleasanton',
      'palo alto',
      'daly city',
      'mountain view',
      'san jose',
      'berkeley',
      'fremont',
      'emeryville',
    ]
    sf_cities.each do |sub_city|
      sf.sub_cities.create!(name: sub_city.downcase)
    end
  end
end

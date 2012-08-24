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

  def self.add_boston_sub_cities
    bos = City.find_by_name('Boston')
    bos_cities = [
      'cambridge',
      'lowell',
      'brockton',
      'lynn',
      'newton',
      'somerville',
      'lawrence',
      'quincy',
      'allston',
      'peabody',
      'nashua',
      'framingham',
      'waltham',
      'worcester',
    ]
    bos_cities.each do |sub_city|
      bos.sub_cities.create!(name: sub_city.downcase)
    end
  end
end

def create_from_div
  sf = City.find_by_name('San Francisco')
  Restaurant.where(['created_at > ? and created_at < ?', '2012-07-25', '2012-08-10']).destroy_all
  File.open('./data/seed.tsv').each_line do |line|
    line = line.split("\t").map(&:strip)
    r = Restaurant.new

    r.name = line[0]
    r.phone_number = line[1]
    r.category = line[2]
    r.address = line[3]
    r.postal_code = line[4]
    r.yelp_url = line[5]
    r.city_id = sf.id
    r.active = true

    tries = 0
    begin
      tries += 1
      sleep 0.2
      r.save!
    rescue
      if tries < 3
        retry
      else
        puts "ERROR #{line}"
      end
    end
  end
end

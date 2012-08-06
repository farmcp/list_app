FactoryGirl.define do
  sequence :name do |n|
    "Name #{n}"
  end

  sequence :email do |n|
    "user#{Time.now.to_f}@bitelist.com"
  end

  sequence :udid do |n|
    "#{('0' * (40 - n.to_s.length))}#{n}"
  end

  sequence :guid do |n|
    "#{UUIDTools::UUID.random_create}"
  end

  sequence :integer do |n|
    n
  end

end

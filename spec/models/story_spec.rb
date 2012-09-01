# == Schema Information
#
# Table name: stories
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  subject_type  :string(255)
#  subject_id    :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  restaurant_id :integer
#

require 'spec_helper'

describe Story do
  it 'can belong to List' do
    list = FactoryGirl.create(:list)
    expect { Story.create(:subject => list) }.not_to raise_error
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean         default(FALSE)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  fb_id                  :string(255)
#  provider               :string(255)
#  image_url              :string(255)
#

require './spec/spec_helper'

describe 'User' do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  context '' do
    it '' do
      1.should eq 1
    end
  end
end

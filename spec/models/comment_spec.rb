# == Schema Information
#
# Table name: comments
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  restaurant_id :integer
#  body          :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end

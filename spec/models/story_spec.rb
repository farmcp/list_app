require 'spec_helper'

describe Story do
  it 'can belong to List' do
    list = FactoryGirl.create(:list)
    expect { Story.create(:subject => list) }.not_to raise_error
  end
end

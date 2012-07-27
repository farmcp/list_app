require './spec/spec_helper'

describe 'Enumerable' do
  before :each do
    @array = [1,1,1,2,3,4,4,4,4]
  end

  context 'sort_by_frequency' do
    it 'sorts by frequency' do
      @array.sort_by_frequency.should == [4,1,2,3]
    end
  end
end

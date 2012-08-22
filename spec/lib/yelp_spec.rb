require './spec/spec_helper'

describe Yelp do
  before :each do
    @cello_url = 'http://www.yelp.com/biz/cello-kebob-and-pizza-san-francisco'
  end
  context '.parse' do
    before :each do
      cello_file = "#{Rails.root}/spec/fixtures/cello-kebob-and-pizza-san-francisco"
      file_contents = File.open(cello_file).read
      @doc = Nokogiri::HTML(file_contents)
      Yelp.stub(:fetch).and_return(@doc)
    end

    it 'gets restaurant info' do
      @resto = Yelp.parse(@cello_url)
      @resto.name.should == 'Cello Kebob & Pizza'
    end

    context 'in an unknown city' do
      before :each do
        City.stub(:where).and_return([])
      end

      it 'returns nil' do
        Yelp.parse(@cello_url).should be_nil
      end
    end
  end
end

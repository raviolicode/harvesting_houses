require(File.join(File.dirname(__FILE__), '..', 'lib', 'bc_scraper'))

describe BuscandoCasaScraper do
  # TODO: Use separate tests for testing locally and remotely
  
  before do
    @bc = BuscandoCasaScraper.new
  end

  it "should parse conditions correctly" do
    pending("parse conditions correctly")
    pending("this test belongs to scraper")
  end

  it "url and conditions should be ok" do
    pending("should parse conditions instead of having these fixed conditions")
    doc = @bc.get_nokogiri_document_from_url('search_houses_base', '(dormitorios=0 AND preciomensualidad<=9000 AND zonas.idZona=1)')
    doc.should be_an_instance_of(Nokogiri::HTML::Document)
  end

  it "should get houses definitions" do
    @bc.should have(2).search_houses
  end

  it "should scrap data from house definition" do
    reference_id = '359AP209'
    house_data = @bc.scrap_house reference_id 
    house_data.should_not be_empty

    house_data['floor'].should_not be_empty 
    house_data['price'].should_not be_empty
    house_data['quality'].should_not be_empty
    house_data['construction_year'].should_not be_empty
  end

  # 
  # only call obtain house_data once
  it "should show correct floor" do
    pending("Refactor so I won't have one declaration for each attribute. One test for each attribute")
    # house_data[attr].should_not be_empty
    # test_attribute 'floor'
  end

  # def test_attribute attr
  #   house_data[attr].should_not be_empty
  #   
  #   # After cleaning the data, test should be:
  #   # house_data[attr].should_be eql(expected_value) 
  # end
end


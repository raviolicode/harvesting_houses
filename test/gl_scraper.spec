require(File.join(File.dirname(__FILE__), '..', 'lib', 'gl_scraper'))

describe GallitoLuisScraper do 
  # TODO: Use separate tests for testing locally and remotely

  before do
    @scraper = GallitoLuisScraper.new
  end

  it "neighboorhoods should not be empty" do
    pending ""
  end

  it "should have search parameters that work ok" do
    pending ""
  end

  it "should get a search form" do
    page = @scraper.search_houses_form
    page.should be_instance_of(Mechanize::Page)
  end

  it "should get search params" do
    #TODO: refactor! before do search_houses_form
    page = @scraper.search_houses_form
    search_params =  @scraper.get_search_params page, ["la comercial"]
    search_params.should_not be_empty
    search_params.first.should be_eql "Chkbar$53"
  end

  #TODO: make it work!
  it "should submit the form and get a body" do
    @scraper.search_houses.should be_instance_of(Nokogiri::XML::NodeSet)    
  end
end

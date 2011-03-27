require(File.join(File.dirname(__FILE__), '..', 'lib', 'gl_scraper'))

describe GallitoLuisScraper do 
  # TODO: I should use Mocks to run locally!!! 

  before do
    @scraper = GallitoLuisScraper.new
  end

  it "should have list of neighborhoods not empty" do
    pending("")
  end

  it "should have search parameters that work ok" do
    pending("")
  end

  it "should get a search form" do
    page = @scraper.search_houses_form
    page.should be_instance_of(Mechanize::Form)
  end

  it "should get search params" do
    #TODO: refactor! before do search_houses_form
    page = @scraper.search_houses_form
    search_params =  @scraper.get_search_params page, ["la comercial"]
    search_params.should_not be_empty
    search_params.first.should be_eql "Chkbar$53"
  end

  it "should submit the form and get a body" do
    @scraper.search_houses.should be_instance_of(Nokogiri::XML::NodeSet)    
  end
end

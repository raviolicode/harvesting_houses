require_relative "bc_scraper" 
require 'nokogiri'

describe BuscandoCasaScraper do
  #TODO: usar mocks y archivos locales para no conectarme a internet?
  
  before do
    @bc = BuscandoCasaScraper.new
  end

  it "get_document_from_url should get a NOKOGIRI document" do
    doc = @bc.get_document_from_url('search_houses_base', '(dormitorios=0 AND preciomensualidad<=9000 AND zonas.idZona=1)')
    doc.should be_an_instance_of(Nokogiri::HTML::Document)
  end

  it "should get houses definitions" do
    @bc.should have(2).houses_reference_ids
  end

  it "should scrap data from house definition" do
    reference_id = '359AP209'
    house_data = @bc.scrap_house reference_id 
    house_data.should_not be_empty

    # house_data['direccion'].should_not be_empty
    # house_data['dormitorios'].should_not be_empty

    house_data['piso'].should_not be_empty 
    house_data['precio'].should_not be_empty
    house_data['estado'].should_not be_empty
    house_data['anio_construccion'].should_not be_empty
    # house_data['superficie edificada'].should_not be_empty
  end
end


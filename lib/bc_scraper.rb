# coding: utf-8
require_relative 'scraper'

# TODO Use Mechanize!!
class BuscandoCasaScraper < Scraper
  # def initialize
  #   @urls = Scraper.load_config('urls')
  # end

  def search_houses 
    # TODO: build conditions outside the method
    # TODO: need more flexible conditions
    conditions_equal = {'dormitorios' => 0, 'alquileres.alquilado' => 'N', 'ciudades.idciudad' => 1, 'zonas.idZona' => 1, 'G00' => 's', 'unidad' => 'p', 'va' => 'S'}
    conditions_less_or_equal = {'preciomensualidad' => 9000, 'year(apartamentos.fua)' => 2010}
    search_conditions = build_conditions_query conditions_equal, conditions_less_or_equal 
    document = get_nokogiri_document_url 'buscando_casa_search_properties', search_conditions 

    document.css('input').map{|e| e.attributes['value'].value}
  end

  def scrap_house reference_id
    document = get_nokogiri_document_url 'buscando_casa_house_details', reference_id
    scraping_values = Scraper.load_config('scraping_values') 
    
    # solution for malformed HTML in every possible way
    # TODO: look for different cases if param_location fits every case
    scraping_values.inject({}) do |result, house_attribute|
      parameter = house_attribute.first 
      param_location = house_attribute[1]
      result[parameter] = document.xpath(param_location['xpath'])[param_location['index']].content

      result
    end
  end
end


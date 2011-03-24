# coding: utf-8
require_relative 'scraper'
require 'open-uri'
require 'nokogiri'
require 'yaml'

class BuscandoCasaScraper < Scraper
  def initialize
    url = File.join(File.dirname(__FILE__), '/../config/urls.yml')
    @urls = open(url){ |f| YAML.load(f) }
  end

  def houses_reference_ids
    # TODO: build conditions outside the method
    # TODO: need more flexible conditions
    conditions_equal = {'dormitorios' => 0, 'alquileres.alquilado' => 'N', 'ciudades.idciudad' => 1, 'zonas.idZona' => 1, 'G00' => 's', 'unidad' => 'p', 'va' => 'S'}
    conditions_less_or_equal = {'preciomensualidad' => 9000, 'year(apartamentos.fua)' => 2010}
    search_conditions = build_conditions_query conditions_equal, conditions_less_or_equal 
    document = get_document_from_url 'search_houses_base', search_conditions 

    document.css('input').map{|e| e.attributes['value'].value}
  end

  def scrap_house reference_id
    url = File.join(File.dirname(__FILE__), '..', 'config', 'scraping_values.yml')
    scraping_values = open(url){ |f| YAML.load(f) }
    document = get_document_from_url 'house_definition_base', reference_id
    
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


# coding: utf-8
require_relative 'scraper'
require 'open-uri'
require 'nokogiri'
require 'yaml'

class BuscandoCasaScraper < Scraper
  def initialize
    @urls = open('../config/urls.yml'){ |f| YAML.load(f) }
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
    # scraping_values = open('../config/scraping_values.yml'){ |f| YAML.load(f) }
    document = get_document_from_url 'house_definition_base', reference_id
    house_params = 
      document.css('td.tabla2').zip(document.css('td.tabla2+th')).inject({}) do |result, val| 
        # TODO: hacerme second? 
        result[clean_field val.first] = val[1].children.map{|children| children.content unless children.content.empty?}.compact.join("; ") if val[1] && val.first 
        result
      end
  end
end


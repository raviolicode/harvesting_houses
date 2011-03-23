# coding: utf-8
require_relative 'scraper'
require 'open-uri'
require 'nokogiri'
require 'yaml'

class BuscandoCasaScraper < Scraper
  def initialize
    @urls = open('urls.yml'){ |f| YAML.load(f) }
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
    document = get_document_from_url 'house_definition_base', reference_id
    house_params = 
      document.css('td.tabla2').zip(document.css('td.tabla2+th')).inject({}) do |result, val| 
        result[clean_field val.first] = clean_field val[1] if val[1] && val.first #.second 
        result
      end
  end

  def save house_params
    # TODO cambiar esto por algo mejor  
    # House.create!(:address => house_params['direccion'],
    #               :dorms => house_params['dormitorios'],
    #               :surface => house_params['superficie edificada'],
    #               :ref => ref)
    # :description => house_params['descripcion'],
  end
end


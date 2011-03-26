require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'yaml'

# TODO: make a factory
class Scraper
  def initialize
    @urls = Scraper.load_config('urls')
  end

  def build_conditions_query conditions_equal, conditions_less_or_equal
    #TODO: should be a class method?
    #TODO: complete and remove repetition 
    all_conditions = conditions_equal.map{|condition, value| "#{condition} = #{value.inspect.gsub("\"","\'")}"} + \
                     conditions_less_or_equal.map{|condition, value| "#{condition} <= #{value.inspect.gsub("\"","\'")}"}
    query = all_conditions.join(' AND ') 

    "(#{query})" 
  end

  def save house_params
    house_params.each{|param, value| puts "#{param.capitalize}: #{value}" }
    # House.create!(params)
  end

  # This method belong on the Scraper Class, or should it be on a Utility class???
  def self.load_config config_name
    url = File.join(File.dirname(__FILE__), '..', 'config', "#{config_name}.yml")
    open(url){ |f| YAML.load(f) }
  end

  #TODO: I don't like this two methods (get_nokogiri, get_url). The will merge into one when I change BuscandoCasaScraper to Mechanize 
  def get_nokogiri_document_from_url base_url, params=nil
    url = URI.escape(@urls[base_url] + params)
    Nokogiri::HTML(open(url))
  end

  def get_url_from_config url
    @urls[url]
  end
end


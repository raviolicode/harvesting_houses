require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib', 'bc_scraper')

bc = BuscandoCasaScraper.new
refs = bc.houses_reference_ids
refs.each do |ref|
  puts '*-----------------------------------*'
  puts ref
  puts '*-----------------------------------*'
  house_data = bc.scrap_house ref
  bc.save house_data
end

